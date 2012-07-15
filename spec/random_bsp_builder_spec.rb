require 'spec_helper'

class FakeRng
  PICKING_A_CUTTING_DIRECTION = 2
  PICKING_A_NEW_HEIGHT = 37
  CUT_HORIZONTALLY = 1
  HALF_HEIGHT = 17
  def self.rand(max)
    case max
    when PICKING_A_CUTTING_DIRECTION
      return CUT_HORIZONTALLY
    when PICKING_A_NEW_HEIGHT
      return HALF_HEIGHT
    end
  end
end
 
def volume_cut_with_random_algorithm
  BspNode.new(:width => 40, :height => 40, :subnodes =>
              [ BspNode.new(:width => 40, :height => 20),
                BspNode.new(:width => 40, :height => 20, :yoffset => 20)])
end

describe "BspBuilder using the random bsp algorithm" do
  it "should still have a subdivide_volume_to_depth method" do
    bsptree = BspBuilder.new(:bsp_algorithm => RandomBsp.new)
    bsptree.should respond_to(:subdivide_volume_to_depth)
  end

  it "should divide the given volume using the random algorithm" do
    bsptree = BspBuilder.new(:bsp_algorithm => RandomBsp.new, :root_node => BspNode.new(:width => 40, :height => 40))
    subnodes = bsptree.subdivide_volume_to_depth(1).subnodes
    subnodes.first.class.should == BspNode
    subnodes.last.class.should == BspNode
  end

  context "using a mocked RNG" do
    before(:each) do
      @random_bsp = RandomBsp.new
      @random_bsp.setrng(FakeRng)
    end

    it "should divide a 40x40 volume horizontally into two 40x20 volumes" do
      bsptree = BspBuilder.new(:bsp_algorithm => @random_bsp, :root_node => BspNode.new(:width => 40, :height => 40))
      bsptree.subdivide_volume_to_depth(1).should == volume_cut_with_random_algorithm
    end
  end
end
