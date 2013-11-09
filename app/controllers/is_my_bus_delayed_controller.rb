require 'nokogiri'
class IsMyBusDelayedController < ApplicationController
  layout "is_my_bus_delayed"


  # GET /
  # GET /.json
  # GET /.xml
  def index
    #Project.hit 35
    if params[:bus]
      @bus_stop = BusStop.find_by_naptan_code(params[:bus])
      @buses = get_buses(@bus_stop.naptan_code) unless @bus_stop.nil?
    end

    respond_to do |format|
      format.html
      format.json { render json: @buses, callback: params[:callback] }
      format.xml { render xml: @buses }
    end
  end


  # GET /stops
  # GET /stops.json
  # GET /stops.xml
  def stops
    if params['lat'] and params['lng']
      @page[:order] = params[:order] || "distance ASC"
      @page[:limit] = params[:limit] || 5
      distance = "7912*ASIN(SQRT(POWER(SIN((lat-#{params['lat']})*pi()/180/2),2)+COS(lat*pi()/180)*COS(#{params['lat']}*pi()/180)*POWER(SIN((lng-#{params['lng']})*pi()/180/2),2)))"
      @stops =  BusStop.select("bus_stops.*, #{distance} AS distance").where("lat IS NOT NULL AND lng IS NOT NULL").paginate(@page)
    end

    respond_to do |format|
      format.html 
      format.json { render json: @stops, callback: params[:callback] }
      format.xml { render xml: @stops }
    end
  end


  private
    def get_buses from
      
      xml = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\r\n<Siri version=\"1.0\" xmlns=\"http://www.siri.org.uk/\">\r\n<ServiceRequest>\r\n"
      xml += "<RequestorRef>TravelineAPI157</RequestorRef>\r\n<StopMonitoringRequest version=\"1.0\">\r\n<RequestTimestamp>#{Time.now}</RequestTimestamp>\r\n"
      xml += "<MessageIdentifier>#{Time.now.to_i}</MessageIdentifier>\r\n<MonitoringRef>#{from}</MonitoringRef>\r\n</StopMonitoringRequest>\r\n</ServiceRequest>\r\n</Siri>"
      url = "http://TravelineAPI157:Vjh84Kds@nextbus.mxdata.co.uk/nextbuses/1.0/1"

      api_call url, xml
    end


    private
      def api_call url, xml
  
        begin
          response = RestClient.post url, xml
        rescue Exception => e
          logger.error "#{Time.now} Could not get bus details: #{e.message}"
          return []
        end
  
        return [] if response.code != 200
  
        begin
          xml = Nokogiri::XML(response.body)
          buses = []
          xml.css('MonitoredStopVisit').each do |bus|
            scheduled = bus.css('AimedDepartureTime').text
            scheduled = DateTime.parse(scheduled).strftime('%H:%M') unless scheduled.empty?
            expected = bus.css('ExpectedDepartureTime').text
            expected = DateTime.parse(expected).strftime('%H:%M') unless expected.empty?
            
            buses << {  
              bus_number: bus.css('PublishedLineName').text,
              direction: bus.css('DirectionName').text,
              operator_code: bus.css('OperatorRef').text,
              scheduled: scheduled,
              expected: expected
            }
          end
          return buses
        rescue Exception => e
          logger.error "#{Time.now} Could not get buses: #{e.message}"
          return []
        end

      end

end