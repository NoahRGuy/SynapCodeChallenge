class League < ActiveRecord::Base
	has_many :people
	has_many :league_event_joins
	has_many :events, -> { distinct }, through: :league_event_joins
end