module EventDecorator
  DATETIME_FORMAT = "%d-%m-%Y %H:%M".freeze
  def user_name
    creator.present? ? creator.username : ''
  end

  def start_datetime
    starttime.strftime(DATETIME_FORMAT)
  end

  def end_datetime
    endtime.present? ? endtime.strftime(DATETIME_FORMAT) : ''
  end

  def all_day?
    allday ? 'Yes' : 'No'
  end
end