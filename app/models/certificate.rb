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

      Rails.logger.info "Running certbot"
      if system('sudo certbot certonly --non-interactive --keep-until-expiring --cert-name dyl.anjon.es --webroot --webroot-path "/home/rails/public" -d dyl.anjon.es,ismytraindelayed.com,isitaproxyproblem.com,dylanjones.info,alice-jones.co.uk')
        Rails.logger.info("Ran certbot successfully")
      else
        Rails.logger.error "Certbot failed. Status #{$?.exitstatus}"
        return
      end

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
