require 'ipaddr'
class IpToolsController < ApplicationController


  # GET /ip-tools
  # GET /ip-tools.json
  # GET /ip-tools.xml
  def index
    Project.hit 56

    if params[:q]
      @results = []
      begin
        ip = IPAddr.new(params[:q])
        @results << ["Integer", ip.to_i]
        @results << ["Start Range", ip.to_range.first, ip.to_range.first.to_i]
        @results << ["End Range", ip.to_range.last, ip.to_range.last.to_i]
        @results << ["Addresses", ip.to_range.last.to_i - ip.to_range.first.to_i + 1]
        if ip.ipv4?
          @results << ["Mapped", ip.ipv4_mapped]
        elsif ip.ipv6?
          @results << ["Mapped", ip.ipv6_mapped]
        end
      rescue
        params[:q].to_i
      end
    else
      @results = [request.remote_ip]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @results, callback: params[:callback] }
      format.xml { render xml: @results }
    end
  end


end