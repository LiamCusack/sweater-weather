class PrescriptionTrailsService
  class << self

    def find_trails(dest)
      response = conn.get("/api/filter/") do |req|
        req.params[:by] = "city"
        req.params[:city] = dest
        req.params[:offset] = "0"
        req.params[:count] = "10"
      end
      JSON.parse(json_parse(response), symbolize_names: true)
    end

    private

    def conn
      Faraday.new(url: 'https://prescriptiontrails.org')
    end

    def json_parse(response)
      JSON.parse(response.body.to_json, symbolize_names: true)
    end
  end
end
