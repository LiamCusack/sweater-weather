class BackgroundsFacade
  class << self

    def get_background(location)
      image = find_image(location)

    end

    def find_image(location)
      images = PexelsService.retrieve_images(location)
    end

  end
end
