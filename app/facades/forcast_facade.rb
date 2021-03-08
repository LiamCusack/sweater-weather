class ForcastFacade
  def self.find_location(params)
    @location = ForcastService.find_location(params)
  end
end
