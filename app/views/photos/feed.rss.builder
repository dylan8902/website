xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Dylan Jones:: Photos"
    xml.description "Photos I have taken and uploaded to Flickr."
    xml.link photos_url

    for photo in @photos
      xml.item do
        xml.title photo.title
        xml.description photo.description
        xml.pubDate photo.created_at.to_s(:rfc822)
        xml.link photo_url(photo)
        xml.guid photo_url(photo)
      end
    end
  end
end