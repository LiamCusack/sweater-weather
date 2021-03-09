class TrailsFacade
  class << self

    def get_trip_itinerary(start, dest, min_steps)
      trails = get_trails(dest, min_steps)
      directions = get_directions(trails)
      forecast = get_forcast(directions)
      build_itinerary(forecast)
    end

    def build_itinerary(forecast)
      forecast.map do |trail|
        TrailItinerary.new(trail)
      end
    end

    def get_forecast(directions)
      forecast = directions.each do |trail|
        coords = trail[:directions][:results].first[:locations].first[:latLng]
        trail[:forecast] = OpenWeatherService.get_weather_latlong(coords[:lat], coords[:long])
      end
    end

    def get_directions(trails)
      directions = trails.each do |trail|
        trail[:directions] = MapquestService.find_location(trail[:address])
      end
      directions
    end

    def get_trails(dest, min_steps)
      all_trails = PrescriptionTrailsService.find_trails(dest)
      trails_with_min_steps(all_trails, min_steps)
    end

    def trails_with_min_steps(trails, min_steps)
      trails[:trails].select do |trail|
        trail[:loops][:"1"][:steps] >= min_steps.to_i
      end
      trails[:trails].first(3)
    end

  end
end
