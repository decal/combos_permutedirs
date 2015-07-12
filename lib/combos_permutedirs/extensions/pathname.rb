require 'pathname'
require 'combos_permutedirs/mixin'

class Pathname
  include Combinatorics::PermuteDirs::Mixin
end
