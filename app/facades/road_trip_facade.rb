class RoadTripFacade
  class << self
    def create_road_trip(start, dest)
      directions = MapquestService.get_directions(start, dest)
      weather = weather_at_eta(dest, directions[:route][:formattedTime])
    end
  end
end
