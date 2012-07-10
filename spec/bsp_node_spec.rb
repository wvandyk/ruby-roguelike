require 'spec_helper'

# TODO
# Break these classes off into their own modules
# Implement vert & horizontal offsets in BspNode
class BspNode
  attr_reader :width, :subnodes, :height

  def initialize(options = {})
    @subnodes = options[:subnodes] || []
    @width = options[:width] || nil
    @height = options[:height] || nil
  end

  def ==(other_instance)
    self.attributes == other_instance.attributes
  end

  def attributes
    {:subnodes => subnodes, :width => width, :height => height}
  end

  def subnodes=(array_of_subnodes)
    @subnodes = array_of_subnodes
  end
end

class BspBuilder
  def initialize(options = {})
    @starting_width = options[:width]
    @starting_height = options[:height]
    @root_node = BspNode.new(:width => @starting_width, :height => @starting_height)
    @options = options
  end

  def subdivide_volume(options = {:start_node => nil, :depth => 0})
    working_node = options[:start_node] || @root_node
    return working_node if options[:depth] == 0
    new_volume = chop_volume(working_node, pick_which_direction_to_cut(working_node))
    working_node.subnodes = [ 
      subdivide_volume(:start_node => BspNode.new(new_volume), :depth => options[:depth] - 1),
      subdivide_volume(:start_node => BspNode.new(new_volume), :depth => options[:depth] - 1)
    ]
    working_node
  end

  def chop_volume(node, direction)
    if direction == :vertical
      return_hash = { :width => halve(node.width), :height => node.height }
    else
      return_hash = { :width => node.width, :height => halve(node.height) }
    end
    return_hash
  end

  def halve(integer_no)
    (integer_no.to_f / 2.0).to_i
  end

  def pick_which_direction_to_cut(node = nil)
    working_node = node || @root_node
    if working_node.width >= working_node.height
      return :vertical
    else
      return :horizontal
    end
  end

end

describe "generating a bsp tree" do
  it "should return the original starting volume at depth 0" do
    bsptree = BspBuilder.new(:width => 80, :height => 21).subdivide_volume(:depth => 0)
    bsptree.should == BspNode.new(:width => 80, :height => 21, :subnodes => [])
  end

  it "should return the original starting volume and two half volumes at depth 1" do
    bsptree = BspBuilder.new(:width => 80, :height => 21).subdivide_volume(:depth => 1)
    bsptree.should == BspNode.new(:width => 80, :height => 21, 
                                  :subnodes => [
                                    BspNode.new(:width => 40, :height => 21), 
                                    BspNode.new(:width => 40, :height => 21)])
  end

  it "should return the original starting volume, two half volumes and 4 quarter volumes at depth 2" do
    bsptree = BspBuilder.new(:width => 40, :height => 21).subdivide_volume(:depth => 2)
    bsptree.should == BspNode.new(:width => 40, :height => 21, 
                                  :subnodes => [
                                    BspNode.new(:width => 20, :height => 21, :subnodes => [
                                                BspNode.new(:width => 20, :height => 10),
                                                BspNode.new(:width => 20, :height => 10)
                                                ]), 
                                    BspNode.new(:width => 20, :height => 21, :subnodes => [
                                                BspNode.new(:width => 20, :height => 10),
                                                BspNode.new(:width => 20, :height => 10)
                                                ]) 
                                  ])
  end


  it "should be able to decide which direction to subdivide the volume" do
    bsptree = BspBuilder.new(:width => 80, :height => 21)
    bsptree.pick_which_direction_to_cut.should == :vertical
  end
end

describe BspNode do
  it "should be able to return a hash of it's attributes" do
    bspnode = BspNode.new(:width => 80, :height => 21, :subnodes => [1, 2, 3])
    bspnode.attributes.should == {:width => 80, :height => 21, :subnodes => [1, 2, 3]}
  end
end
