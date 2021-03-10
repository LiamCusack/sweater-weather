class FlickrService
  class << self

    def retrieve_images(location)
      response = conn.get("/services/rest/?method=flickr.photos.search&text=denver") do |req|
        req.params['api_key'] = ENV['FLICKR_API_KEY']
        req.params[:method] = "flickr.photos.search"
        req.params[:text] = location
      end
      json_parse(response)
    end

    def get_image_url
      
    end

    private

    def conn
      Faraday.new(url: 'https://api.flickr.com')
    end

    def json_parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
