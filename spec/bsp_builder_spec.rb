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

describe BspBuilder do
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


