# TODO
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
