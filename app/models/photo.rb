class Photo < ActiveRecord::Base
  default_scope order('created_at DESC')

  def self.update page = 1
    url = "http://api.flickr.com/services/rest?method=flickr.people.getPublicPhotos" +
          "&api_key=" + ENV['FLICKR_API_KEY'] + "&user_id=43191158@N06" +
          "&extras=description,url_sq,url_o,machine_tags,date_upload,geo" +
          "&per_page=100&format=json&page=#{page}"
    response = RestClient.get url
    return nil if response.code != 200
    string = response.body.gsub('jsonFlickrApi(', '')
    string = string[0...-1]
    json = JSON.parse string
    
    json['photos']['photo'].each do |photo|
      
      photo['latitude'] = nil if photo['latitude'] == 0
      photo['longitude'] = nil if photo['longitude'] == 0
      
      Photo.where(id: photo['id']).first_or_create(
        title: photo['title'],
        description: photo['description']['_content'],
        original: photo['url_o'],
        thumbnail: photo['url_sq'],
        lat: photo['latitude'],
        lng: photo['longitude'],
        created_at: Time.at(photo['dateupload'].to_i),
        updated_at: Time.now
      )  
    end
  end

  def map_marker_text
    "<img src=\\\"#{self.thumbnail}\\\" width=55>".html_safe
  end

end
