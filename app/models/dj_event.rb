class DjEvent < ActiveRecord::Base
  default_scope { order('created_at DESC') }
  has_many :dj_tracks
end
