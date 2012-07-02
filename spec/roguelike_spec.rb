require 'spec_helper'

describe Roguelike do

  context "Renderer" do

    it "should be able to setup an instance of the renderer" do
      Roguelike::Renderer::NcursesApi.any_instance.should_receive(:setup)
      roguelike = Roguelike::Roguelike.new
    end

    it "should shutdown the renderer at exit" do
      Roguelike::Renderer::NcursesApi.any_instance.stub(:setup)
      Roguelike::Renderer::NcursesApi.any_instance.should_receive(:destroy)
      roguelike = Roguelike::Roguelike.new
      roguelike.quit
    end
  end

end
