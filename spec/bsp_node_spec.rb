require 'spec_helper'

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
