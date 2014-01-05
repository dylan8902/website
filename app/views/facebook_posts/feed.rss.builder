xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Dylan Jones:: Facebook Posts"
    xml.description "Posts I have made on Facebook."
    xml.link facebook_posts_url

    for facebook_post in @facebook_posts
      xml.item do
        xml.title facebook_post.text
        xml.description facebook_post.text
        xml.pubDate facebook_post.created_at.to_s(:rfc822)
        xml.link facebook_post_url(facebook_post)
        xml.guid facebook_post_url(facebook_post)
      end
    end
  end
end