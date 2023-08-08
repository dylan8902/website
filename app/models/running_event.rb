class RunningEvent  < StravaEvent
  default_scope { where(sport: 'Run') }
  default_scope { order('created_at DESC') }
end
