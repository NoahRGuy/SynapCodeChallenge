class Event < ActiveRecord::Base
  default_scope { order(created_at: :asc) }

  has_many :checkins
  has_many :league_event_joins
  has_many :leagues, -> { distinct }, through: :league_event_joins
  has_many :people, -> { distinct }, through: :checkins
end
