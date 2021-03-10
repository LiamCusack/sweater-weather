class UnsplashService
  class << self

    def retrieve_images(location)
      response = conn.get("/search/photos") do |req|
        req.params['client_id'] = ENV['UNSPLASH_API_KEY']
        req.params[:per_page] = 1
        req.params[:query] = location
      end
      json_parse(response)
    end

    private

    def conn
      Faraday.new(url: 'https://api.unsplash.com')
    end

    def json_parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
