class BspBuilder
  def initialize(options = {})
    @bsp_algorithm = options[:bsp_algorithm] || NonRandomBsp.new
    @node_class = BspNode
    @root_node = options[:root_node]
  end

  def subdivide_volume_to_depth(depth = 0, working_node = @root_node)
    return working_node if depth == 0
    working_node.subnodes = chopped_volume_subnodes(depth - 1, working_node)
    return working_node
  end

  private

  def chopped_volume_subnodes(depth, node)
    subnodes_from_chop = bsp_algorithm(node).chop_volume
    [ subdivide_volume_to_depth(depth, subnodes_from_chop.first),
      subdivide_volume_to_depth(depth, subnodes_from_chop.last) ]
  end

  def bsp_algorithm(node)
    @bsp_algorithm.setnode(node)
    @bsp_algorithm
  end
end
