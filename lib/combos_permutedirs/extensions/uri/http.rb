require'combos_permutedirs/mixins'

class URI::HTTP
  include Combinatorics::PermuteDirs::Mixin
end

class URI::HTTPS
  include Combinatorics::PermuteDirs::Mixin
end
