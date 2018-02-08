class LeaguesController < ApplicationController

	def show
		@league = League.find(params[:id])
		@event = Event.find(params[:event_id])
		@leaderboard = @event.order_by_up_by
    @leaderboard.each do |person|
    	person.up_by = person.up_by(@event)
    end
    @leag_lead = @leaderboard.select {|person| person.league.id == @league.id}
	end
end