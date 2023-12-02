module TimeHelper

  def localized_datetime(datetime)
    I18n.l(datetime, format: :datetime_for_console) if datetime
  end

  def localized_date_with_year(timestamp)
    I18n.l(Time.at(timestamp), format: :date_with_year)
  end
end
