class AddDietaryRequirementsToWeddingRsvp < ActiveRecord::Migration[5.0]
  def change
    add_column :wedding_rsvps, :dietary_requirements, :text
  end
end
