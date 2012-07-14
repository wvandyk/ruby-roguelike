require 'spec_helper'

def bsp_tree_at_depth_1
  BspNode.new(:width => 80, :height => 21, 
              :subnodes => [
                BspNode.new(:width => 40, :height => 21, :xoffset => 0), 
                BspNode.new(:width => 40, :height => 21, :xoffset => 40)])
end

def bsp_tree_at_depth_2
  BspNode.new(:width => 40, :height => 21, 
              :subnodes => [
                BspNode.new(:width => 20, :height => 21, :xoffset => 0, :subnodes => [
                            BspNode.new(:width => 20, :height => 10),
                            BspNode.new(:width => 20, :height => 10, :yoffset => 10)]), 
                BspNode.new(:width => 20, :height => 21, :xoffset => 20, :subnodes => [
                            BspNode.new(:width => 20, :height => 10, :xoffset => 20),
                            BspNode.new(:width => 20, :height => 10, :xoffset => 20, :yoffset => 10)]) 
  ])
end

class RandomBspBuilder < BspBuilder
  # This class only needs to re-implement the following functions to use a random number generator
  # 
  # def cutting_direction(node)
  # def nodes_from_vertical_cut(node)
  # def nodes_from_horizontal_cut(node)
end

describe "generating a bsp tree" do
  it "should return the original starting volume at depth 0" do
    bsptree = BspBuilder.new(:width => 80, :height => 21)
    bsptree.subdivide_volume_to_depth(0).should == BspNode.new(:width => 80, :height => 21, :subnodes => [])
  end

  it "should return the original starting volume and two half volumes at depth 1" do
    bsptree = BspBuilder.new(:width => 80, :height => 21)
    bsptree.subdivide_volume_to_depth(1).should == bsp_tree_at_depth_1
  end

  it "should return the original starting volume, two half volumes and 4 quarter volumes at depth 2" do
    bsptree = BspBuilder.new(:width => 40, :height => 21)
    bsptree.subdivide_volume_to_depth(2).should == bsp_tree_at_depth_2
  end

  it "should set the offsets of the volumes after a vertical split to the correct values" do
    bspbuilder = BspBuilder.new(:width => 40, :height => 21)
    bsptree = bspbuilder.subdivide_volume_to_depth(1)
    bsptree.subnodes.first.xoffset.should == 0
    bsptree.subnodes.last.xoffset.should == 20
  end

  it "should set the offsets of the volumes after a horizontal split to the correct values" do
    bspbuilder = BspBuilder.new(:width => 10, :height => 21)
    bsptree = bspbuilder.subdivide_volume_to_depth(1)
    bsptree.subnodes.first.yoffset.should == 0
    bsptree.subnodes.last.yoffset.should == 10
  end
end

describe RandomBspBuilder do
  it "should still have a subdivide_volume_to_depth method" do
    bsptree = RandomBspBuilder.new
    bsptree.should respond_to(:subdivide_volume_to_depth)
  end
end

describe BspNode do
  it "should be able to return a hash of it's attributes" do
    bspnode = BspNode.new(:width => 80, :height => 21, :subnodes => [1, 2, 3])
    bspnode.attributes.should == {
      :width => 80, :height => 21, :xoffset => 0, 
      :yoffset => 0, :subnodes => [1, 2, 3]}
  end

  it "should have an xoffset value" do
    bspnode = BspNode.new(:width => 80, :height => 21)
    bspnode.xoffset.should == 0
  end

  it "should have a yoffset value" do
    bspnode = BspNode.new(:width => 80, :height => 21)
    bspnode.yoffset.should == 0
  end

  it "should present its x and y offsets in the attributes hash" do
    bspnode = BspNode.new(:width => 80, :height => 21)
    bspnode.attributes.should include(:xoffset => 0)
    bspnode.attributes.should include(:yoffset => 0)
  end
end
