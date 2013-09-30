class DjTrack < ActiveRecord::Base
  default_scope order('created_at ASC')
  belongs_to :dj_event
  
  def to_param
    self.artist_mbid
  end
end
