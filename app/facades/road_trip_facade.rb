class RoadTripFacade
  class << self
    def create_road_trip(start, dest)
      is_route_possible(start, dest)
    end

    def weather_at_eta(start, dest, travel_time)
      location = ForecastFacade.find_location(dest)
      coords = ForecastFacade.get_coordinates(location)
      weather = ForecastFacade.get_weather(coords)
      eta_forecast = weather[:hourly].detect do |hour|
        hour[:dt] >= (travel_time.to_i + Time.now.to_i)
      end
      w_a_eta = { temperature: (eta_forecast[:temp] - 273.15) * (9/5) +32, conditions: eta_forecast[:weather][0][:description]}
      RoadTrip.new(w_a_eta, start, dest, travel_time)
    end

    def is_route_possible(start, dest)
      directions = MapquestService.get_directions(start, dest)
      if directions[:route][:formattedTime].present?
        weather_at_eta(start, dest, directions[:route][:formattedTime])
      else
        results = {}
        RoadTrip.new(results, start, dest, "impossible route")
      end
    end
  end
end
