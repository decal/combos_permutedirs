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
    #   ``anurl'' is an URL as a String type and becomes a Ruby URI object
    #
    # @raise [TypeError] 
    #   ``anurl'' must be a String when passed to initialize
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
    def initialize(anurl = '')
      anarr, anapc = [], anurl.class

      raise(TypeError,'anurl must be a kind of String or URI!') if !(anapc.kind_of?(String) and anapc.kind_of?(URI))

      anarr
    end
  end
end
