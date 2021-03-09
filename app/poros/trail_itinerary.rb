class TrailItinerary
  attr_reader :trail_name, :travel_time, :difficulty, :parking, :loops, :forecast

  def initialize(trail)
    @trail_name = trail[:name]
    @travel_time =
    @difficulty =
    @parking =
    @loops =
    @forecast =
  end
end
