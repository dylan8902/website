class DuoLeaderboard < ApplicationRecord
  has_and_belongs_to_many :duo_participants

  def ranked
    ranked = []
    self.duo_participants.each do |user|
      xp = user.xp['summaries']
      ranked << { user: user, xp: xp, total: xp.sum { |h| h['gainedXp'] || 0 } }
    end
    sorted = ranked.sort_by { |h| h[:total] }
    sorted.reverse!
  end
end
