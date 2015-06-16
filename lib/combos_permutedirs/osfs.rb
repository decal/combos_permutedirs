#
# @author Derek Callaway <decal@ethernet.org>
#
# @version 0.8.0
#
module Combinatorics::PermuteDirs
  #
  # Class to be used for detecting directory derangements on the "Operating 
  #   System's File System."
  #
  # @since 0.8.0
  #
  class OSFS 
    #
    # @param [String] apath 
    #   Pathname to detect derangements under..
    #   
    # @raise [TypeError]
    #   Exception raised when ``apath'' isn't a kind of String or Pathname
    #
    # @return [Array] 
    #   An Array of Pathname's which are guaranteed to exist and be accessible
    #
    # @see Pathname
    #
    # @example DerangeDirs::OSFS.new('a/b/c/d/e.gif') => []
    #
    def initialize(apath, opts = {})
      anarr, anapc = [], apath.class

      raise(TypeError,'apath must be a kind of String or Pathname!') if !apath or !(anapc.kind_of?(String) or anapc.kind_of?(Pathname))

      delim, apath = '/', apath.to_s
      delim = opts[:delim] if opts.key?('delim')  
      parry = apath.split(delim)

      for 2 .. parray.size - 1 do |k|
        parry.permute(k).each do |e|
          yield e

          anarr << e
        end
      end

      anarr
    end
  end
end
