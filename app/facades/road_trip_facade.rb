class RoadTripFacade
  def create_road_trip(start, dest)
    directions = MapquestService.get_directions(start, dest)
  end
end
