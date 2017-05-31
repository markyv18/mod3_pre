require 'rails_helper'

RSpec.describe "As a user" do
  context "When I visit the root and click on a destination" do
    it "I'm on a location page & see 10 day forecast for that destination" do

      location = Destination.create!(name: "boulder",
                                     zip: "80305",
                                     description: "it's great",
                                     image_url: "https://ssl.cdn-redfin.com/photo/91/mbpaddedwide/943/genMid.787943_2.jpg")
      visit '/'

      expect(current_path).to eq(root_path)

      click_on 'Show'

      expect(current_path).to eq('/destinations/1')

      expect(page).to have_content(location.name)
      expect(page).to have_content(location.zip)
      expect(page).to have_content(location.description)

      location_weather = DestinationWeatherService.new(location.zip).forecast

      response = Faraday.get("http://api.wunderground.com/api/ee12eda69c8089c6/forecast10day/q/#{location.zip}.json")
      days = JSON.parse(response.body, symbolize_names: true) [:forecast][:simpleforecast][:forecastday]

      expect(days.count).to eq(10)
      expect(page).to have_content(location_weather[0].weekday)
      expect(page).to have_content(location_weather[0].month)
      expect(page).to have_content(location_weather[0].date)
      expect(page).to have_content(location_weather[0].high_temp)
      expect(page).to have_content(location_weather[0].low_temp)
      expect(page).to have_content(location_weather[0].conditions)

    end
  end
end














#
