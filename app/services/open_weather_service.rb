class OpenWeatherService
  class << self

    def get_weather(lat, long)
      response = conn.get("/data/2.5/onecall") do |req|
        req.params['appid'] = ENV['OPEN_WEATHER_API_KEY']
        req.params[:lat] = lat
        req.params[:lon] = long
        req.params[:exclude] = "minutely"
      end
      json_parse(response)
    end

    private

    def conn
      Faraday.new(url: 'https://api.openweathermap.org')
    end

    def json_parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
