xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Dylan Jones:: Episodes"
    xml.description "Episodes I have watched on BBC iPlayer"
    xml.link episodes_url

    for episode in @episodes
      xml.item do
        xml.title episode.title
        xml.description episode.description
        xml.pubDate episode.created_at.to_s(:rfc822)
        xml.link episode_url(episode)
        xml.guid episode_url(episode)
      end
    end
  end
end