class Event < ActiveRecord::Base
  default_scope { order(created_at: :asc) }

  has_many :checkins
  has_many :league_event_joins
  has_many :leagues, -> { distinct }, through: :league_event_joins
  has_many :people, -> { distinct }, through: :checkins

  def order_by_up_by
  	order = []
  	self.people.each do |person|
  		person.up_by = person.up_by(self)
  		if person.up_by.nil?
  			person.up_by = 0.0
  		end
  		order.push(person)
  	end
  	order.sort_by! {|person| person.up_by}
  	order.reverse!
  end
end
