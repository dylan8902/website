require 'nokogiri'
require 'open-uri'
class BbcTwitter < ActiveRecord::Base
  self.table_name = "bbc_twitter"  
  
  def self.update

    return if BbcTwitter.where("created_at > ?", Date.today).count > 0

    urls = [
      "http://polling.bbc.co.uk/moira/feed/news_world/front_page",
      "http://polling.bbc.co.uk/moira/feed/news_world/americas",
      "http://polling.bbc.co.uk/moira/feed/news_world/technology",
      "http://polling.bbc.co.uk/moira/feed/news_world/front_page/features_mobile_feed",
      "http://polling.bbc.co.uk/moira/feed/news_world/business",
      "http://polling.bbc.co.uk/moira/feed/news_world/science/nature",
      "http://polling.bbc.co.uk/moira/feed/news_world/europe",
      "http://polling.bbc.co.uk/moira/feed/news_world/world/latin_america",
      "http://polling.bbc.co.uk/moira/feed/news_world/uk_news",
      "http://polling.bbc.co.uk/moira/feed/news_world/world/asia",
      "http://polling.bbc.co.uk/moira/feed/news_world/middle_east",
      "http://polling.bbc.co.uk/moira/feed/news_world/africa",
      "http://polling.bbc.co.uk/moira/feed/news_world/entertainment",
      "http://polling.bbc.co.uk/moira/feed/news_world/health",
      "http://polling.bbc.co.uk/moira/feed/news_world/also_in_the_news"
    ]

    urls.each do |url|
      xml = Nokogiri::XML(open(url))    
      xml.css('entry').each do |entry|
        title = entry.css('title').text
        link = entry.css('link').first[:href]
        count = entry.css('content').to_s.scan(/twitter|tweet/i).size
        BbcTwitter.where(title: title, link: link, count: count).first_or_create if count > 0
      end
    end

  end


  def self.latest
    return BbcTwitter.where("created_at > ?", Date.today).order("count DESC")
  end


end
