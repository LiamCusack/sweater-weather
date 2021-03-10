class DailyWeather
  attr_reader :date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon

  def initialize(data)
    @date = Time.at(data[:dt]).strftime('%Y-%m-%d')
    @sunrise = Time.at(data[:sunrise]).to_s
    @sunset = Time.at(data[:sunset]).to_s
    @max_temp = (data[:temp][:max] - 273.15) * (9/5) +32
    @min_temp = (data[:temp][:min] - 273.15) * (9/5) +32
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end
