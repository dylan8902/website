class CyclingEvent  < StravaEvent
  default_scope { where(sport: 'Ride') }
  default_scope { order('created_at DESC') }
end
