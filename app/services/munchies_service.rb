class MunchiesService
  class << self

    def get_weather(lat, long)
      response = weatherconn.get("/data/2.5/onecall") do |req|
        req.params['appid'] = ENV['OPEN_WEATHER_API_KEY']
        req.params[:lat] = lat
        req.params[:lon] = long
        req.params[:exclude] = "minutely"
      end
      json_parse(response)
    end

    def find_food(dest, food)
      response = yelpconn.get("/v3/businesses/search") do |req|
        req.params[:location] = dest
        req.params[:term] = food
        req.params[:categories] = "food"
        req.params[:limit] = 1
      end
      json_parse(response)
    end

    private

    def mapconn
      Faraday.new(url: 'https://www.mapquestapi.com')
    end

    def weatherconn
      Faraday.new(url: 'https://api.openweathermap.org')
    end

    def yelpconn
      Faraday.new(url: 'https://api.yelp.com') do |req|
        req.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
      end
    end

    def json_parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
