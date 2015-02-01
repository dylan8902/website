class Gig < ActiveRecord::Base
  default_scope { order('created_at DESC') }
  has_many :gig_artists


  def self.update page = 1
    url = "http://api.songkick.com/api/3.0/users/dylan8902/gigography.json?apikey=" + ENV['SONGKICK_API_KEY'] + "&page=#{page}"
    begin
      response = RestClient.get url
    rescue => e
      logger.info "Gig update problem: " + e.message
      return
    end
    return if response.code != 200

    json = JSON.parse response.body
    json['resultsPage']['results']['event'].each do |event|

      gig = Gig.where(id: event['id']).first_or_create(url: event['uri'], name: event['displayName'])
      
      if event['venue']['displayName'] != "Unknown venue"
        gig.venue = event['venue']['displayName']
      else
        gig.venue = event['location']['city']
      end

      if event['venue']['lat']
        gig.lat = event['venue']['lat']
      else
        gig.lat = event['location']['lat']
      end

      if event['venue']['lng']
        gig.lng = event['venue']['lng']
      else
        gig.lng = event['location']['lng']
      end

      if event['start']['datetime']
        gig.created_at = event['start']['datetime']
      else
        gig.created_at = event['start']['date']
      end
          
      gig.save

      event['performance'].each do |performer|
        if performer['artist']['identifier'].first
          mbid = performer['artist']['identifier'][0]['mbid']
        end
        GigArtist.where(
          gig_id: gig.id,
          name: performer['artist']['displayName']
        ).first_or_create(
          url: performer['artist']['uri'],
          mbid: mbid
        )
      end

    end

  end


end