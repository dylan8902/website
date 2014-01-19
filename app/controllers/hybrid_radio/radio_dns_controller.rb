class HybridRadio::RadioDnsController < ApplicationController

  # GET /hybrid/radiodns
  # GET /hybrid/radiodns.json
  # GET /hybrid/radiodns.xml
  def index
    if params[:freq] and params[:pi] and params[:ecc]
      @result = get_radio_dns_services params
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @result, callback: params[:callback] }
      format.xml { render xml: @result }
    end
  end


  private
    def get_radio_dns_services params
      resolver = Resolv::DNS.new
      result = {
        services: { radiovis: {}, radioepg: {}, radiotag: {} }
      }

      result[:fqdn] = "#{params[:freq]}.#{params[:pi]}.#{params[:ecc]}.fm.radiodns.org"
      cname = resolver.getresources(result[:fqdn], Resolv::DNS::Resource::IN::CNAME).first

      if cname
        result[:cname] = cname.name.to_s
        result[:services].each do |k, v|
          lookup = "_#{k}._tcp.#{result[:cname]}"
          res = resolver.getresources(lookup, Resolv::DNS::Resource::IN::SRV).first
          result[:services][k] = { host: res.target.to_s, port: res.port } if res
        end
      end

      return result
    end

end