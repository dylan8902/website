class Episode < ActiveRecord::Base
  belongs_to :user
  default_scope { order('created_at DESC') }


  def to_param
    self.pid
  end


  def image
    "https://www.bbc.co.uk/iplayer/images/episode/#{self.pid}_640_360.jpg"
  end


  def self.add url, user
    params = url.split('/')
    
    response = RestClient.get "http://www.bbc.co.uk/programmes/#{params[5]}.json"
    if response.code != 200
      return
    end
    
    json = JSON.parse response.body
    if json['programme'].nil?
      return
    end
    
    if json['programme']['display_title']['subtitle'].empty?
      title = json['programme']['display_title']['title']
    else
      title = json['programme']['display_title']['title'] + ", " + json['programme']['display_title']['subtitle']
    end
    
    if !json['programme']['short_synopsis'].empty?
      description = json['programme']['short_synopsis']
    elsif !json['programme']['medium_synopsis'].empty?
      description = json['programme']['medium_synopsis']
    else
      description = json['programme']['long_synopsis']
    end
    
    return Episode.create(pid:params[5], title: title, description: description, user_id: user.id)
  end

end
