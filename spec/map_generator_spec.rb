require 'spec_helper'

describe Roguelike::MapGenerator do
  context "Initialization" do
    it "should take the max width and height of the new map as parameters" do
      map_generator = Roguelike::MapGenerator.new(:height => 10, :width => 20)
      map_generator.width.should == 20
      map_generator.height.should == 10
    end

    it "should default to 21x80 when no dimensions are provided" do
      map_generator = Roguelike::MapGenerator.new()
      map_generator.width.should == 80
      map_generator.height.should == 21
    end

    it "should take an RNG implementation and seed when being initialized" do
      Nrng.should_receive(:new).with(123)
      map_generator = Roguelike::MapGenerator.new(:rng => Nrng, :seed => 123)
    end

    it "should use the standard ruby Random class and the current epoch time if no rng or seed were passed in" do
      timeobj = mock Time
      timeobj.should_receive(:strftime).with("%s").and_return("123")
      Time.should_receive(:now).and_return(timeobj)
      Random.should_receive(:new).with(123)
      map_generator = Roguelike::MapGenerator.new()
    end
  end

  context "The non-random number generator for testing" do
    it "should return the same list of numbers over and over again" do
      nrng = Nrng.new(123)
      list_of_generated_nums = 10.times.collect { nrng.integer(10) }
      list_of_generated_nums.should == [10, 21, 3, 17, 24, 8, 18, 10, 21, 3]
    end
  end

  it "should generate a bsp tree of the given area" do
    pending
    map_generator = Roguelike::MapGenerator.new(:height => 21, :width => 80, :rng => Nrng, :seed => 123)
    map_generator.bsp_tree(:depth => 1).should ==
    BspNode.new(:width => 80, :height => 21, :x => 0, :y => 0,
      :subnodes => [
        BspNode.new(:width => 40, :height => 21, :x => 0, :y => 0, :subnodes => nil),
        BspNode.new(:width => 40, :height => 21, :x => 41, :y => 0, :subnodes => nil)
      ]
    )
  end
end
