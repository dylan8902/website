xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Dylan Jones:: Accounts"
    xml.description "My account passwords."
    xml.link accounts_url

    for account in @accounts
      xml.item do
        xml.title account.name
        xml.description account.number
        xml.pubDate account.created_at.to_s(:rfc822)
        xml.link account_url(account)
        xml.guid account_url(account)
      end
    end
  end
end