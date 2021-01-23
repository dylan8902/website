class OauthClient < ApplicationRecord

  default_scope { order('created_at DESC') }

  # Redirect URL
  def full_redirect_uri(request)
    CGI.escape("#{request.base_url}/oauth/authorise/#{id}")
  end

  # Authorisation URL
  def authorise_url(request)
    "#{redirect_uri}?client_id=#{client_id}&response_type=#{response_type}&redirect_uri=#{full_redirect_uri(request)}"
  end

  # Excahnge code for token
  def exchange(code)
    url = "https://www.strava.com/api/v3/oauth/token"
    params = {
      client_id: client_id,
      client_secret: client_secret,
      code: code,
      grant_type: "authorization_code"
    }
    begin
      response = RestClient.post url, params
    rescue => e
      logger.info "Code exchange problem: " + e.message
      return
    end
    return if response.code != 200

    logger.info "Code exchange: " + response.body
    return JSON.parse response.body
  end

end
