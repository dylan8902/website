require 'openssl'
require 'fileutils'


class Certificate

  def self.renew
    begin
      current_cert = OpenSSL::X509::Certificate.new(File.read('/etc/website.crt'))

      if current_cert.not_after > 1.month.from_now
        Rails.logger.info "Certificate is valid for at least another month (#{current_cert.not_after})"
        return
      end

      Rails.logger.info "Renewing certificate"

      private_key = OpenSSL::PKey.read(File.read('/etc/website.key'))

      client = Acme::Client.new(private_key: private_key, directory: 'https://acme-v02.api.letsencrypt.org/directory')
      account = client.new_account(contact: 'mailto:dyl@anjon.es', terms_of_service_agreed: true)

      domains = [
        'dyl.anjon.es',
        'ismytraindelayed.com',
        'isitaproxyproblem.com',
        'dylanjones.info',
        'alice-jones.co.uk'
      ]

      order = client.new_order(identifiers: domains)

      Rails.logger.info "Removing old challenges"
      FileUtils.rm_r "public/.well-known/acme-challenge"

      order.authorizations.each do |auth|
        challenge = auth.http
        file_path = "public/#{challenge.filename}"
        dir_path = File.dirname file_path
        FileUtils.mkdir_p dir_path

        Rails.logger.info "Writing challenge #{file_path}"
        File.write(file_path, challenge.file_content)
        challenge.request_validation

        timeout = 30
        until challenge.status != 'pending' or timeout == 0
          challenge.reload
          sleep(2)
          timeout -= 2
        end
      end

      csr = Acme::Client::CertificateRequest.new(names: domains, subject: { common_name: domains.first })
      order.finalize(csr: csr)

      timeout = 30
      until order.status != 'processing' or timeout == 0
        order.reload
        sleep(1)
        timeout -= 1
      end

      Rails.logger.info "Writing new certificate"
      File.write('/etc/website.crt', order.certificate)

      Rails.logger.info "Reloading nginx"
      if system('sudo systemctl reload nginx')
        Rails.logger.info("Reloaded nginx successfully")
      else
        Rails.logger.error "Reload of nginx failed. Status #{$?.exitstatus}"
      end
    end
  rescue Exception => e
    Rails.logger.error "Failed to renew certificate"
    Rails.logger.error e.message
  end
end
