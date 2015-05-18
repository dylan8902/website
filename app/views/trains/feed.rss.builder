xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Dylan Jones:: Trains"
    xml.description "Train journeys I have been on."
    xml.link trains_url

    for train in @trains
      xml.item do
        xml.title train.to_s
        xml.description train.to_s
        xml.pubDate train.created_at.to_s(:rfc822)
        xml.link train_url(train)
        xml.guid train_url(train)
      end
    end
  end
end