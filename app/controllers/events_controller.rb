class EventsController < ApplicationController
  def index
    @events = Event.all.order(:id)
  end

  def show
    @event = Event.find(params[:id])
    @leagues = @event.leagues   
    @event.people.each do |person|
      person.determine_starting_weight(@event)
    end
    @leaderboard = @event.order_by_up_by
    @leaderboard.each do |person|
      person.up_by = person.up_by(@event)
    end
  end

end
