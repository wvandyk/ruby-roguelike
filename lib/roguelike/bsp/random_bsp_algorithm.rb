require File.dirname(__FILE__)+'/bsp_algorithm'

class RandomBsp < BspAlgorithm

  MIN_NODE_WIDTH = 3
  MIN_NODE_HEIGHT = 3

  private

  def cutting_direction
    cutting_directions = [:vertical, :horizontal]
    cutting_directions[@rng.rand(cutting_directions.length)]
  end

  def nodes_from_vertical_cut
    width_node1 = random_in_range(MIN_NODE_WIDTH, @node.width - MIN_NODE_WIDTH)
    width_node2 = @node.width - width_node1
    [@node_class.new(:width => width_node1, :height => @node.height, 
                     :xoffset => @node.xoffset, :yoffset => @node.yoffset),
     @node_class.new(:width => width_node2, :height => @node.height, 
                     :xoffset => @node.xoffset + width_node1, :yoffset => @node.yoffset)]
  end

  def nodes_from_horizontal_cut
    height_node1 = random_in_range(MIN_NODE_HEIGHT, @node.height - MIN_NODE_HEIGHT)
    height_node2 = @node.height - height_node1
    [@node_class.new(:width => @node.width, :height => height_node1, 
                     :xoffset => @node.xoffset, :yoffset => @node.yoffset),
     @node_class.new(:width => @node.width, :height => height_node2, 
                     :xoffset => @node.xoffset, :yoffset => @node.yoffset + height_node1)]
  end

  def random_in_range(min, max)
    @rng.rand(max) + min
  end
end


