class ForecastFacade
  class << self

    def find_location(params)
      ForecastService.find_location(params)
    end

    def get_coordinates(latlong)
       latlong[:results].first[:locations].first[:latLng]
    end

    def get_weather(coordinates)
      ForecastService.get_weather(coordinates[:lat], coordinates[:lng])
    end

    def find_forecast(params)
      location = find_location(params)
      coordinates = get_coordinates(location)
      weather = get_weather(coordinates)
      store_weather(weather)
    end

    def store_weather(weather)
      current = make_current(weather[:current])
      daily = make_daily(weather[:daily])
      hourly = make_hourly(weather[:hourly])
      make_forecast(current, daily, hourly)
    end

    def make_forecast(current, daily, hourly)
      Forecast.new(current, daily, hourly)
    end

    def make_current(data)
      CurrentWeather.new(data)
    end

    def make_daily(data)
      data.first(5).map do |day|
        DailyWeather.new(day)
      end
    end

    def make_hourly(data)
      data.first(8).map do |hour|
        HourlyWeather.new(hour)
      end
    end

  end
end
