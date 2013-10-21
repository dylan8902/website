class Analytic < ActiveRecord::Base

  def self.hit request
     Analytic.create(
       uri: request.original_url,
       ip: request.remote_ip,
       user_agent: request.user_agent,
       referer: request.referer
     )
  end

end