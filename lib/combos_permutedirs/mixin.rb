require 'combinatorics'
require 'uri'

module Combinatorics
#
# @author Derek Callaway <decal@ethernet.org>
#
# @version 0.8.0
#
# @since 0.8.0
#
# Class to be used for helping to detect directory permutations on the WWW
  module PermuteDirs
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
    module Mixin
      def permute_dirs(&block)
        anurl = self.to_s

        anurl.chomp!('/')

        return enum_for(:new_paths, anurl) unless block_given?

        raise(TypeError,'anurl must be a kind of String or URI!') if !(anurl.kind_of?(String) or anurl.kind_of?(URI))

        apath = self.path

        raise(EOFError,'anurl must have a path!') if apath.blank?

        asplt = apath.split('/') 
        anarr, asize = [], asplt.size - 1

        raise(RangeError,'anurl path depth must be more than one!') if asize < 2
        raise(RangeError,'anurl path depth must be less than twenty!') if asize > 20

        asplt[1 .. asize].power_set.each do |s|
          if block_given?
            anobj = s.permute(s.size)

            anarr << anobj unless block_given?

            yield anobj
          end
        end 

        return anarr unless block_given?
      end
    end
  end
end
