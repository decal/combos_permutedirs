# encoding: utf-8
#
# @author Derek Callaway <decal@ethernet.org>
#
# @version 0.8.5
#
# @since 0.8.0
#

require 'combos_permutedirs/mixins'
require 'uri'

module URI
  class HTTPS
    include Combinatorics::PermuteDirs::Mixin
  end
end
