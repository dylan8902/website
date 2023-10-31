xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Dylan Jones:: Duo Leaderboards"
    xml.description "Duo leaderboards."
    xml.link duo_leaderboards_url

    for leaderboard in @leaderboards
      xml.item do
        xml.title leaderboard.name
        xml.description leaderboard.number
        xml.pubDate leaderboard.created_at.to_s(:rfc822)
        xml.link duo_leaderboard_url(leaderboard)
        xml.guid duo_leaderboard_url(leaderboard)
      end
    end
  end
end