require 'ncurses'
require 'roguelike/renderer'
require 'roguelike/map_generator'
require 'roguelike/bsp_node'
require 'roguelike/non_random_bsp_algorithm'
require 'roguelike/bsp_builder'
require 'roguelike/version'

module Roguelike

  # Implements a rudimentary roguelike engine in ruby with ncurses
  class Roguelike
    def initialize(render_api = Renderer::NcursesApi)
      @render_api = render_api
      renderer.setup
    end

    def renderer
      @renderer ||= @render_api.new
    end

    def quit
      renderer.destroy
    end
  end
end
