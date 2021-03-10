class HourlyWeather
  attr_reader :time, :temp, :conditions, :icon

  def initialize(data)
    @time = Time.at(data[:dt]).strftime('%H:%M:%S').to_s
    @temp = (data[:temp] - 273.15) * (9/5) +32
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end
