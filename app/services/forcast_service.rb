class ForcastService
  class << self
    def find_location(params)
      response = mapconn.get("/address?location=#{params}")
      binding.pry
      parse(response)
    end

    private

    def mapconn
      Faraday.new(url: 'https://www.mapquestapi.com/geocoding/v1') do |req|
        req.params['key'] = ENV["02jAvp0vEqqqdEE6wOj0LSLfTPxNbusG"]
      end
    end

    def weatherconn
      Faraday.new(url: 'https://api.openweathermap.org/data/2.5/onecall') do |req|
        req.params['appid'] = ENV['d696231cc0ace5074ad2bb82117808a5']
      end
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
