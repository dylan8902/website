class GoDaddyDns

  def self.update_anjones_txt subdomain, value
    auth = "sso-key #{Rails.application.secrets.go_daddy_key}:#{Rails.application.secrets.go_daddy_secret}"
    headers = { authorization: auth, content_type: :json, accept: :json }
    url = "https://api.godaddy.com/v1/domains/anjon.es/records/TXT/#{subdomain}"
    payload = [
      {
        "data" => value,
        "name" => subdomain,
        "ttl" => 1800,
        "type" => "TXT"
      }
    ]
    return RestClient.put url, payload.to_json, headers
  end

  def self.update_dev_dylanjones_acme value
    return update_anjones_txt "_acme-challenge.dev.dyl", value
  end

  def self.update_dylanjones_acme value
    return update_anjones_txt "_acme-challenge.dyl", value
  end

end
