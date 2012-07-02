module Roguelike

  # Will implement the bsp map generation algorithm as given at:
  # http://roguebasin.roguelikedevelopment.org/index.php?title=Basic_BSP_Dungeon_generation
  class MapGenerator

    attr_reader :width, :height

    def initialize(options = {})
      set_map_dimensions(:width => options[:width], :height => options[:height])
      set_random_number_generator(:rng => options[:rng], :seed => options[:seed])
    end

    def set_map_dimensions(dimensions = {})
      @width = dimensions[:width] || 80
      @height = dimensions[:height] || 21
    end

    def set_random_number_generator(rng_options = {})
      @seed = rng_options[:seed] || Time.now.strftime("%s").to_i
      randomizer = rng_options[:rng] || Random
      @rng = randomizer.new(@seed)
    end

  end
end
