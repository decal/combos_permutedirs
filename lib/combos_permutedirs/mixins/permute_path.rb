#
# @author Derek Callaway <decal@ethernet.org>
#
# @version 0.8.5
#
# @since 0.8.0
#
module Combinatorics::PermuteDirs
  #
  # @raise [TypeError] 
  #   `anurl` must be a `String` when passed to initialize
  #
  # @raise [EOFError]
  #   `anurl` must have a slash after the hostname or IP address
  #
  # @raise [NameError]
  #   `anurl` must have a directory depth of more than one
  #
  # @yield [pathlist] Array<Array<String>>
  #   The given block will be passed two-dimensional Arrays of recombinant 
  #   directory path names
  #
  # @yieldparam [String] path 
  #   The directory names as a unique ordering in a `path`
  #
  # @return [Array]
  #   An Array containing Object's of type String is returned if no block is provided
  #
  # @see URI#path
  #
  # @note If no block is passed as input, an Enumerator Object is returned
  #
  # @see Enumerator
  #
  # @example String.new('http://www.google.com/a/b').permute_path { |x| x.each { |y| puts y } }
  #
  def permute_path(&ablok)
    anurl = self.to_s

    anurl.chomp!('/')
    anurl.strip!

    raise(TypeError,'anurl must be a kind of String or URI!') if !(anurl.kind_of?(String) or anurl.kind_of?(URI))

    apath = self.path

    raise(EOFError,'anurl must have a path!') if apath.blank?

    asplt = apath.split('/') 
    anarr, asize = [], asplt.size - 1

    raise(RangeError,'anurl path depth must be greater than one and less than twenty-five!') asize < 2 or asize > 24

    asplt[1 .. asize].power_set.each do |a|
      anobj = a.permute(a.size) # compute k-permutations where k = a.size

      anarr << anobj unless block_given?

      yield anobj
    end

    block_given? ? anarr : enum_for(:String, anarr)
  end

  def permute_uris permute_path
  def permpowset_path permute_path
  def permpowset_uris permute_path
  def permutepowerset_path permute_path
  def permutepowerset_uris permute_path
end
