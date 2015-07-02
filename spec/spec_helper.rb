gem 'rspec', '>= 3.3.0'
require 'rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

require 'combos_permutedirs/version'

include Combinatorics::PermuteDirs
