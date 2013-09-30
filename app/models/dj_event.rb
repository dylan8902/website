class DjEvent < ActiveRecord::Base
  attr_accessible :title, :location, :description, :image
  default_scope order('created_at DESC')
  has_many :dj_tracks
end
