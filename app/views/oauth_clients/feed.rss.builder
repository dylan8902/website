xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Dylan Jones:: OAuth Clients"
    xml.description "My Oauth Clients."
    xml.link oauth_clients_url

    for oauth_client in @oauth_clients
      xml.item do
        xml.title oauth_client.name
        xml.description oauth_client.name
        xml.pubDate oauth_client.created_at.to_s(:rfc822)
        xml.link oauth_client_url(oauth_client)
        xml.guid oauth_client_url(oauth_client)
      end
    end
  end
end