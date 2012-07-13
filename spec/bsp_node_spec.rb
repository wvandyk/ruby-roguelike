require 'spec_helper'

def bsp_tree_at_depth_1
  BspNode.new(:width => 80, :height => 21, 
              :subnodes => [
                BspNode.new(:width => 40, :height => 21), 
                BspNode.new(:width => 40, :height => 21)])
end

def bsp_tree_at_depth_2
  BspNode.new(:width => 40, :height => 21, 
              :subnodes => [
                BspNode.new(:width => 20, :height => 21, :subnodes => [
                            BspNode.new(:width => 20, :height => 10),
                            BspNode.new(:width => 20, :height => 10)]), 
                BspNode.new(:width => 20, :height => 21, :subnodes => [
                            BspNode.new(:width => 20, :height => 10),
                            BspNode.new(:width => 20, :height => 10)]) 
  ])
end

describe "generating a bsp tree" do
  it "should return the original starting volume at depth 0" do
    bsptree = NonRandomBspBuilder.new(:width => 80, :height => 21)
    bsptree.subdivide_volume_to_depth(0).should == BspNode.new(:width => 80, :height => 21, :subnodes => [])
  end

  it "should return the original starting volume and two half volumes at depth 1" do
    bsptree = NonRandomBspBuilder.new(:width => 80, :height => 21)
    bsptree.subdivide_volume_to_depth(1).should == bsp_tree_at_depth_1
  end

  it "should return the original starting volume, two half volumes and 4 quarter volumes at depth 2" do
    bsptree = NonRandomBspBuilder.new(:width => 40, :height => 21)
    bsptree.subdivide_volume_to_depth(2).should == bsp_tree_at_depth_2
  end
end

describe BspNode do
  it "should be able to return a hash of it's attributes" do
    bspnode = BspNode.new(:width => 80, :height => 21, :subnodes => [1, 2, 3])
    bspnode.attributes.should == {:width => 80, :height => 21, :subnodes => [1, 2, 3]}
  end
end
