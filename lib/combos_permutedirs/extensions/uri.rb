require 'combinatorics'
require 'combos_permutedirs/mixin'

class URI::HTTP
  include Combinatorics::PermuteDirs::Mixin
end

class URI::HTTPS
  include Combinatorics::PermuteDirs::Mixin
end
