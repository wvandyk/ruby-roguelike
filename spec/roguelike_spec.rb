require 'spec_helper'

describe Roguelike do

  context "Renderer" do

    it "should be able to setup an instance of the renderer" do
      Roguelike::Renderer::NcursesApi.should_receive(:new).and_return(mock 'ncursesapi', :setup => true)
      roguelike = Roguelike::Roguelike.new
    end

    it "should shutdown the renderer at exit" do
      ncursesapi = mock 'ncursesapi', :setup => true
      Roguelike::Renderer::NcursesApi.stub(:new).and_return(ncursesapi)
      ncursesapi.should_receive(:destroy)
      roguelike = Roguelike::Roguelike.new
      roguelike.quit
    end
  end

end
