# Non random number generator for testing
class Nrng

  NON_RANDOM_NUMS = [10, 21, 3, 17, 24, 8, 18]

  def initialize(seed)
    @cursor = 0
  end

  def integer(range)
    nrn = NON_RANDOM_NUMS[@cursor]
    @cursor = (@cursor + 1) % NON_RANDOM_NUMS.length
    nrn
  end
end
