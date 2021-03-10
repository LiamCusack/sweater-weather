class MunchiesFacade
  class << self

    def expedition_to_munchies(start, dest, food)
      find_route(start, dest)
      find_food(dest, food)
      find_forcast(dest)
    end

    def find_route(start, dest)
      MunchiesService.find_route(start, dest)
    end

    def find_food(dest, food)
      MunchiesService.find_food(dest, food)
    end

  end
end
