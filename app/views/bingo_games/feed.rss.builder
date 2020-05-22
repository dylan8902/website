xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Dylan Jones:: Bingo Games"
    xml.description "Bingo Games."
    xml.link bingo_games_url

    for bingo_game in @bingo_games
      xml.item do
        xml.title bingo_game.id
        xml.description bingo_game.current_number
        xml.pubDate bingo_game.created_at.to_s(:rfc822)
        xml.link bingo_games_url
        xml.guid bingo_game.id
      end
    end
  end
end