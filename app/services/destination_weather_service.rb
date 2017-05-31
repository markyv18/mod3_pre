class DestinationWeatherService

  def initialize(zip)
    @zip = zip
  end

  def forecast
    response = Faraday.get("http://api.wunderground.com/api/ee12eda69c8089c6/forecast10day/q/#{@zip}.json")
    days = JSON.parse(response.body, symbolize_names: true) [:forecast][:simpleforecast][:forecastday]

    days.map do |day|
      DestinationWeather.new(day[:date][:weekday], day[:date][:month], day[:date][:day], day[:high][:fahrenheit], day[:low][:fahrenheit], day[:conditions])
    end
  end

end
