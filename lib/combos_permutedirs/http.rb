require 'uri'

#
# @author Derek Callaway <decal@ethernet.org>
#
# @version 0.8.0
#
module Combinatorics::PermuteDirs
  #
  # Class to be used for detecting directory derangements on the World Wide Web
  #
  # @since 0.8.0
  #
  class HTTP
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
    #   An Array of URL's that don't return HTTP error: 404 Not Found
    #
    # @see URI#initialize
    #
    # @example r = Derangements::HTTP.new('http://www.google.com/a/b/c/d/e.gif')
    #
    # @todo make powerset dirs with &block .. use &block here?
    #
    def initialize(anurl = '', &block)
      anarr = []

      raise(TypeError,'anurl must be a kind of String or URI!') if !(anurl.kind_of?(String) or anurl.kind_of?(URI))

      anurl = URI(anurl) if !anurl.kind_of?(URI)
      apath = anurl.path

      raise(EOFError,'anurl must have a path!') if apath.empty?

      asplt = apath.split('/') 

      raise(NameError,'anurl path depth must be more than one!') if asplt.size < 2

      asplt.each do |s|
        if block_given?
          yield s
        else
          anarr << s
        end
      end 

      anarr
    end
  end
end
