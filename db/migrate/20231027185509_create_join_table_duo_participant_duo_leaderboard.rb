class CreateJoinTableDuoParticipantDuoLeaderboard < ActiveRecord::Migration[7.0]
  def change
    create_join_table :duo_participants, :duo_leaderboards do |t|
      t.index [:duo_participant_id, :duo_leaderboard_id], name: 'index_duo'
    end
  end
end
