require 'combinatorics'
require 'uri'

#
# @author Derek Callaway <decal@ethernet.org>
#
# @version 0.8.0
#
# @since 0.8.0
#
module Combinatorics::PermuteDirs
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
  # @yield [pathlist] Array<Array<String>>
  #   The given block will be passed two-dimensional Arrays of recombinant 
  #   directory path names
  #
  # @yieldparam [String] path 
  #   The directory names as a unique ordering in a path
  #
  # @return [Array]
  #   An Array of String's are returned if no block is given
  #
  # @see URI#path
  #
  # @note If no block is given, an Enumerator will be returned
  #
  # @example String.new('http://www.google.com/a/b').permute_uris{|x| x.each{|y| puts y}}
  #
  module Mixin
    def permute_uris(&block)
      anurl = self.to_s

      anurl.chomp!('/')
      anurl.strip!

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
