xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Dylan Jones:: Tweets"
    xml.description "Things I have tweeted on Twitter."
    xml.link tweets_url

    for tweet in @tweets
      xml.item do
        xml.title tweet.text
        xml.description tweet.text
        xml.pubDate tweet.created_at.to_s(:rfc822)
        xml.link tweet_url(tweet)
        xml.guid tweet_url(tweet)
      end
    end
  end
end