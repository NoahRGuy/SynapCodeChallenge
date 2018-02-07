class CreateLeagueEventJoins < ActiveRecord::Migration
  def change
    create_table :league_event_joins do |t|
    	t.references :league, index: true, null: false
    	t.references :event, index: true, null: false
    end
  end
end
