require 'stomp'
class Trains::PpmNational < ActiveRecord::Base

  # Initialize the poller
  def start_poller
    puts "Stomp consumer for Network Rail Open Data Distribution Service"
    client = StompClient.new
    client.run
  end


  # Connect to the service and process messages
  def run
    client_headers = { "accept-version" => "1.1", "heart-beat" => "5000,10000", "client-id" => Socket.gethostname, "host" => ENV['NETWORK_RAIL_HOST'] }
    client_hash = { hosts: [ { login: ENV['NETWORK_RAIL_USERNAME'], passcode: ENV['NETWORK_RAIL_PASSOWRD'], host: ENV['NETWORK_RAIL_HOST'], port: 61618 } ], connect_headers: client_headers }

    client = Stomp::Client.new(client_hash)

    # Check we have connected successfully
    raise "Connection failed" unless client.open?
    raise "Unexpected protocol level #{client.protocol}" unless client.protocol == Stomp::SPL_11
    raise "Connect error: #{client.connection_frame().body}" if client.connection_frame().command == Stomp::CMD_ERROR

    puts "Connected to #{client.connection_frame().headers['server']} server with STOMP #{client.connection_frame().headers['version']}"


    # Subscribe to the RTPPM topic and process messages
    client.subscribe("/topic/RTPPM_ALL", { 'id' => client.uuid(), 'ack' => 'client', 'activemq.subscriptionName' => Socket.gethostname + '-RTPPM' }) do |msg|
      
      client.acknowledge(msg, msg.headers)
      
      data = JSON.parse msg.body
      
      #National PPM data
      n = data["RTPPMDataMsgV1"]["RTPPMData"]["NationalPage"]
      ppm_n = n["NationalPPM"]
      
      Trains::PpmNational.create(
        cancel_very_late: ppm_n["CancelVeryLate"],
        late: ppm_n["Late"],
        msg: n["WebMsgOfMoment"],
        on_time: ppm_n["OnTime"],
        ppm: ppm_n["PPM"]["text"],
        total: ppm_n["Total"]
      )
  
    end

    client.join

    # We will probably never end up here
    client.close
    puts "Client close complete"
  end

end
