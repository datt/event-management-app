class EventsController < ApplicationController
  def index
    @events = filter_events
  end

  private

  # TODO: custom logic written, can move to filter services
  def filter_events
    if params[:start_range] && params[:end_range].present?
      events = Event.between_dates(params[:start_range], params[:end_range])
      if params[:user_id].present?
        event_users = EventUser.where(event_id: events.ids, user_id: params[:user_id], rspvp: 'yes')
        events = events.select { |event| event_users.pluck(:event_id).include?(event.id) }
      end
    else
      events = Event.all
    end
    paginate(events)
  end

  def paginate(events)
    @total_pages = events.count/PER_PAGE
    page_no = params[:page].presence || 1
    events.offset(page_no).limit(PER_PAGE)
  end
end
