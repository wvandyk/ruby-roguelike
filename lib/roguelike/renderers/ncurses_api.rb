module Roguelike
  module Renderer

      # Wrapper for the ncurses-ruby gem so that we have a consistent
      # interface across all the potential renderers we want to support
      class NcursesApi

      def setup
        Ncurses.initscr
      end

      def destroy
        Ncurses.endwin
      end
    end
  end
end
