xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Dylan Jones:: Bingo Numbers"
    xml.description "Bingo Numbers."
    xml.link bingo_numbers_url

    for bingo_number in @bingo_numbers
      xml.item do
        xml.title bingo_number.id
        xml.description bingo_number.instruction
        xml.pubDate bingo_number.created_at.to_s(:rfc822)
        xml.link bingo_number_url(bingo_number)
        xml.guid bingo_number_url(bingo_number)
      end
    end
  end
end