class MapquestService
  class << self

    def find_location(params)
      response = conn.get("/geocoding/v1/address") do |req|
        req.params[:location] = params
        req.params[:key] = ENV['MAPQUEST_API_KEY']
      end
      json_parse(response)
    end

    def get_directions(start, dest)
      response = conn.get("/directions/v2/route") do |req|
        req.params[:from] = start
        req.params[:to] = dest
        req.params[:key] = ENV['MAPQUEST_API_KEY']
      end
      json_parse(response)
    end

    private

    def conn
      Faraday.new(url: 'http://www.mapquestapi.com')
    end

    def json_parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
