require 'combinatorics'
require 'uri'

#
# @author Derek Callaway <decal@ethernet.org>
#
# @version 0.8.0
#
# @since 0.8.0
#
# Class to be used for helping to detect directory permutations on the WWW
module Combinatorics::PermuteDirs::Mixin
  #
  # @param [String] anurl 
  #   `anurl' is an URL as a String type and becomes a Ruby URI object
  #
  # @raise [TypeError] 
  #   `anurl' must be a String when passed to initialize
  #
  # @raise [EOFError]
  #   `anurl' must have a slash after the hostname or IP address
  #
  # @raise [NameError]
  #   `anurl' must have a directory depth of more than one
  #
  # @yield [path] 
  #   The given block will be passed each combination of directory paths 
  #
  # @yieldparam [String] path 
  #   The directory names as a unique ordering in a path
  #
  # @return [Array]
  #   An Array of String's are returned if no block is given
  #
  # @see URI#initialize
  #
  # @see URI#path
  #
  # @example r = URI::HTTP.new_paths('http://www.google.com/a/b/c/d/e.gif')
  #
  # @todo make powerset dirs with &block .. use &block here?
  #
  def help_new_paths(anuri, &block)
    yield anuri.power_set if block_given?
  end

  def new_paths(anurl = '', &block)
    return enum_for(:new_paths, anurl) unless block_given?

    raise(TypeError,'anurl must be a kind of String or URI!') if !(anurl.kind_of?(String) or anurl.kind_of?(URI))

    apath = anurl.path

    raise(EOFError,'anurl must have a non-empty path name!') if apath.blank?

    asplt = apath.split('/') 
    anarr, asize = [], asplt.size - 2

    raise(RangeError,'anurl path depth must be more than one!') if asize < 2
    raise(RangeError,'anurl path depth must be less than twenty!') if asize > 20

    asplt[0 .. asize].permute(asize).each do |s|
      anobj = []
      anobj << help_new_paths(s, &block) if block_given?

      anobj.power_set do |o|
        anarr << help_new_paths(o, &block) if block_given?
      end

      anobj = []
    end 

    anarr 
  end
end
