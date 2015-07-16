# encoding: utf-8
#
# @author Derek Callaway <decal@ethernet.org>
#
# @version 0.8.8
#
# @since 0.8.8
#

require'combos_permutedirs/config'
require'combos_permutedirs/helpers/cast_float'
require'combos_permutedirs/helpers/cast_string'

module Combinatorics::PermuteDirs::Helper
  # 
  # Make an options Hash Object for recombinant directory name computations
  #
  # @param [String, Regexp] ainc
  #   A string or regular expression that when matched is intended to make the
  #   matched elements inclusive with the final output set members 
  #
  # @param [String, Regexp] aexc
  #   A string or regular expression that when matched is intended to exclude
  #   the matched elements from the final output set result
  #
  # @param [Float, Range] choo
  #   Floating-point integer where opposite sides of the decimal point 
  #   represent an integer range. Alternatively, `choo` may be an actual range
  #   object to be used with the binomial relation computed by the combinatorics 
  #   gem's "choose" mixin method; thus, generating only path names whose sizes
  #   fall inclusively within the defined range 
  #
  # @raise [TypeError] 
  #   `ainc` must be a kind of string or regexp object
  #
  # @raise [TypeError]
  #   `aexc` must be a kind of string or regexp object
  #
  # @raise [TypeError]
  #   `choo` must be a kind of float or range object
  #
  # @see Array#choose
  #
  def combine_options(ainc, aexc, choo)
    h = { :include => nil, :exclude => nil, :choose => nil }

    raise(TypeError,'ainc must be a kind of String or Regexp!') if !(ainc.kind_of?(String) or ainc.kind_of?(Regexp))
    raise(TypeError,'aexc must be a kind of String or Regexp!') if !(aexc.kind_of?(String) or aexc.kind_of?(Regexp))
    raise(TypeError,'choo must be a kind of Float or Range!') if !(choo.kind_of?(Float) or choo.kind_of?(Range))

    if ainc.kind_of?(Regexp)
      h[:include] = ainc
    else
      h[:include] = ainc.combos_cast! if ainc.kind_of?(String)
    end

    if aexc.kind_of?(Regexp)
      h[:exclude] = aexc
    else
      h[:exclude] = aexc.combos_cast! if aexc.kind_of?(String)
    end

    if choo.kind_of?(Range)
      h[:choose] = choo
    else
      h[:choose] = choo.combos_cast! if choo.kind_of?(Float)
    end

    h
  end
end
