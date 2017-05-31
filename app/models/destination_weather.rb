class DestinationWeather
  attr_reader :weekday, :month, :date, :high_temp, :low_temp, :conditions

  def initialize (weekday, month, date, high_temp, low_temp, conditions)
    @weekday = weekday
    @month = month
    @date = date
    @high_temp = high_temp
    @low_temp = low_temp
    @conditions = conditions
  end
end
