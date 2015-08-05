class Analytic < ActiveRecord::Base

  def self.hit request
  	referer = nil
  	if request.referer
      referer = request.referer.truncate(255)
    end
    user_agent = nil
    if request.user_agent
      user_agent = request.user_agent.truncate(255)
    end
    remote_ip = nil
    if request.remote_ip
      remote_ip = request.remote_ip.truncate(255)
    end
    original_url = nil
    if request.original_url
      original_url = request.original_url.truncate(255)
    end
     Analytic.create(
       uri: original_url,
       ip: remote_ip,
       user_agent: user_agent,
       referer: referer
     )
  end

end