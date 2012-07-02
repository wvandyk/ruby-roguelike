require 'spec_helper'

describe Roguelike::Renderer do
  context Ncurses do
    it "should issue a call to initscr on the ncurses library" do
      Ncurses.should_receive(:initscr)
      renderer = Roguelike::Renderer::NcursesApi.new
      renderer.setup
    end

    it "should issue a call to endwin on the ncurses library" do
      Ncurses.should_receive(:endwin)
      renderer = Roguelike::Renderer::NcursesApi.new
      renderer.destroy
    end
  end
end
