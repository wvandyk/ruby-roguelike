class BspNode
  attr_reader :width, :subnodes, :height, :xoffset, :yoffset

  def initialize(options = {})
    @subnodes = options[:subnodes] || []
    @width = options[:width] || 0
    @height = options[:height] || 0
    @xoffset = options[:xoffset] || 0
    @yoffset = options[:yoffset] || 0
  end

  def ==(other_instance)
    self.attributes == other_instance.attributes
  end

  def attributes
    {:subnodes => subnodes, :width => width, :height => height, :xoffset => xoffset, :yoffset => yoffset}
  end

  def subnodes=(array_of_subnodes)
    @subnodes = array_of_subnodes
  end
end
