xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Dylan Jones:: Stuff"
    xml.description "Things I have made available online."
    xml.link "http://dyl.anjon.es/stuff"

    for project in @projects
      xml.item do
        xml.title project.title
        xml.description project.description
        xml.pubDate project.created_at.to_s(:rfc822)
        xml.link project.url
        xml.guid project.url
      end
    end
  end
end