class OauthClient < ApplicationRecord

  default_scope { order('created_at DESC') }

  # Redirect URL
  def redirect_uri(request)
    CGI.escape("#{request.base_url}/oauth/authorise/#{id}")
  end

  # Authorisation URL
  def full_authorise_uri(request)
    "#{authorise_url}?client_id=#{client_id}&scope=#{scope}&response_type=#{response_type}&redirect_uri=#{redirect_uri(request)}&state=#{SecureRandom.uuid}"
  end

  # Exchange code for token
  def exchange(code, redirect_url=nil)
    params = {
      client_id: client_id,
      client_secret: client_secret,
      code: code,
      grant_type: "authorization_code",
      redirect_uri: redirect_uri
    }
    begin
      response = RestClient.post token_url, params
    rescue => e
      logger.info "Code exchange problem: " + e.message
      return
    end
    return if response.code != 200

    logger.info "Code exchange: " + response.body
    return JSON.parse response.body
  end

end
