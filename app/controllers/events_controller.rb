class EventsController < ApplicationController
  def index
    @events = filter_events
    # TODO: Setup a user search in different action with autocomplete
    @users = User.all
  end

  private

  # TODO: custom logic written, can move to filter services
  def filter_events
    events = Event.includes(:creator).all
    # to check the user's availability with rsvp 'yes'
    if params[:user_id].present?
      events = events.joins(:event_users)
                     .where('event_users.user_id'=> params[:user_id], 'event_users.rsvp'=> 'yes')
    end
    if params[:start_range].present? && params[:end_range].present?
      events = events.between_dates(params[:start_range], params[:end_range])
    end

    paginate(events)
  end

  def paginate(events)
    @total_pages = events.count/PER_PAGE
    page_no = params[:page].presence || 1
    events.offset(page_no).limit(PER_PAGE)
  end
end
