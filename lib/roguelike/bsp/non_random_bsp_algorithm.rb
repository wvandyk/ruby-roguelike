require File.dirname(__FILE__)+'/bsp_algorithm'

class NonRandomBsp < BspAlgorithm
  private

  def cutting_direction
    if @node.width >= @node.height
      return :vertical
    else
      return :horizontal
    end
  end

  def nodes_from_vertical_cut
    [@node_class.new(:width => halve(@node.width), :height => @node.height, 
                     :xoffset => @node.xoffset, :yoffset => @node.yoffset),

     @node_class.new(:width => halve(@node.width), :height => @node.height, 
                     :xoffset => @node.xoffset + halve(@node.width), 
                     :yoffset => @node.yoffset)]
  end

  def nodes_from_horizontal_cut
    [@node_class.new(:width => @node.width, :height => halve(@node.height), 
                     :xoffset => @node.xoffset, :yoffset => @node.yoffset),

     @node_class.new(:width => @node.width, :height => halve(@node.height), 
                     :xoffset => @node.xoffset,
                     :yoffset => @node.yoffset + halve(@node.height))] 
  end

  def halve(integer_no)
    (integer_no.to_f / 2.0).to_i
  end
end
