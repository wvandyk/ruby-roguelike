class NonRandomBspBuilder
  def initialize(options = {})
    @node_class = options[:node_class] || BspNode
    @root_node = @node_class.new(:width => options[:width], :height => options[:height])
  end

  def subdivide_volume_to_depth(depth = 0, working_node = @root_node)
    return working_node if depth == 0

    working_node.subnodes = [ 
      subdivide_volume_to_depth(depth - 1, chop_volume(working_node)),
      subdivide_volume_to_depth(depth - 1, chop_volume(working_node))]
    return working_node
  end

  private

  def chop_volume(node)
    case cutting_direction(node)
    when :vertical
      @node_class.new(vertical_cut_dimensions(node))
    when :horizontal
      @node_class.new(horizontal_cut_dimensions(node)) 
    end
  end

  def vertical_cut_dimensions(node)
    { :width => halve(node.width), :height => node.height }
  end

  def horizontal_cut_dimensions(node)
    { :width => node.width, :height => halve(node.height) }
  end

  def halve(integer_no)
    (integer_no.to_f / 2.0).to_i
  end

  def cutting_direction(node)
    if node.width >= node.height
      return :vertical
    else
      return :horizontal
    end
  end

end


