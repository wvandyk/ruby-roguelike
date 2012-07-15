class BspAlgorithm

  class UnimplementedInBaseClass < RuntimeError; end

  def initialize(node_class = nil, rng = nil)
    @node = nil
    @node_class = node_class || BspNode
    @rng = rng || Random
  end

  def setnode(node)
    @node = node
  end

  def setnodeclass(nodeclass)
    @node_class = nodeclass
  end

  def setrng(rng)
    @rng = rng
  end

  def chop_volume
    case cutting_direction
    when :vertical
      nodes_from_vertical_cut
    when :horizontal
      nodes_from_horizontal_cut
    end
  end

  private

  def cutting_direction
    raise UnimplementedInBaseClass
  end

  def nodes_from_vertical_cut
    raise UnimplementedInBaseClass
  end

  def nodes_from_horizontal_cut
    raise UnimplementedInBaseClass
  end

end
