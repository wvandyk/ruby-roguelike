require 'spec_helper'

describe Roguelike::MapGenerator do
  context "Initialization" do
    it "should take the max width and height of the new map as parameters" do
      Roguelike::MapGenerator.any_instance.stub(:set_random_number_generator)
      Roguelike::MapGenerator.any_instance.should_receive(:set_map_dimensions).with(:width => 80, :height => 21)
      map_generator = Roguelike::MapGenerator.new(:height => 21, :width => 80)
    end

    it "should default to 21x80 when no dimensions are provided" do
      Roguelike::MapGenerator.any_instance.stub(:set_random_number_generator)
      map_generator = Roguelike::MapGenerator.new(:rng => Random, :seed => 123)
      map_generator.width.should == 80
      map_generator.height.should == 21
    end

    it "should take an RNG implementation and seed when being initialized" do
      Roguelike::MapGenerator.any_instance.stub(:set_map_dimensions)
      Roguelike::MapGenerator.any_instance.should_receive(:set_random_number_generator).with(:rng => Random, :seed => 123)
      map_generator = Roguelike::MapGenerator.new(:rng => Random, :seed => 123)
    end

    it "should use the standard ruby Random class and the current epoch time if no rng or seed were passed in" do
      Roguelike::MapGenerator.any_instance.stub(:set_map_dimensions)
      Time.should_receive(:now).and_return(mock Time, :strftime => "123")
      Random.should_receive(:new).with(123)
      map_generator = Roguelike::MapGenerator.new(:height => 21, :width => 80)
    end
  end

  it "should generate a random bsp tree of the given area" do
    pending
    map_generator = Roguelike::MapGenerator.new(:height => 21, :width => 80)
    map_generator
  end
end
