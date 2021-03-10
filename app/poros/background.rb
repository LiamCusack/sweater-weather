class Background
  attr_reader :id, :location, :image_url, :photographer

  def initialize(image, location)
    @id = nil
    @location = location
    @image_url = image[:results][0][:urls][:full]
    @photographer = image[:results][0][:user][:name]
  end
end
