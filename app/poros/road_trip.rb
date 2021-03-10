class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(results, start, dest, travel_time)
    @id = nil
    @start_city = start
    @end_city = dest
    @travel_time = travel_time
    @weather_at_eta = results
  end
end
