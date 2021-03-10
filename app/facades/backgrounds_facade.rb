class BackgroundsFacade
  class << self

    def get_background(location)
      image = find_image(location)
      Background.new(image, location)
    end
  end
end
