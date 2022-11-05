module ApplicationHelper
  include Pagy::Frontend

  def setting
    @setting ||= Setting.first_or_create
  end

  def nice_date(date)
    date&.strftime('%b %e, %Y')
  end

  def nice_time(datetime)
    datetime&.strftime('%l:%M %p')
  end

  def nice_date_time(datetime)
    datetime&.strftime('%l:%M %p %b %e, %Y')
  end
end
