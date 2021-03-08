class ForecastService
  class << self
    def find_location(params)
      response = mapconn.get("/geocoding/v1/address") do |req|
        req.params[:location] = params
        req.params[:key] = ENV['MAPQUEST_API_KEY']
      end
      json_parse(response)
    end

    def get_weather(lat, long)
      response = weatherconn.get("/data/2.5/onecall") do |req|
        req.params['appid'] = ENV['OPEN_WEATHER_API_KEY']
        req.params[:lat] = lat
        req.params[:lon] = long
        req.params[:exclude] = "minutely"
      end
      json_parse(response)
    end

    private

    def mapconn
      Faraday.new(url: 'http://www.mapquestapi.com')
    end

    def weatherconn
      Faraday.new(url: 'https://api.openweathermap.org')
    end

    def json_parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
