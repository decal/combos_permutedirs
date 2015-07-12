require'combos_permutedirs/mixins'
require'pathname'

class Pathname
  include Combinatorics::PermuteDirs::Mixin
end
