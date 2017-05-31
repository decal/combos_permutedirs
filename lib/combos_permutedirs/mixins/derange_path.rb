# encoding: utf-8

#require'uri'
#require'combos_permutedirs/config'

require 'combinatorics'

#
# @author Derek Callaway <decal@ethernet.org>
#
# @version 0.8.8
#
# @since 0.8.8
#
module Combinatorics::PermuteDirs::Mixin
  # @param [Hash] dopts
  #   derangement options hash object
  #
  # @options [Regexp] :exclude
  #   regular expression pattern to identify elements for exclusion
  #
  # @options [Regexp] :include
  #   regular expression pattern to identify elements for inclusion, thus 
  #   overriding any prior exclusion match
  #
  # @options [Fixnum, Integer, Float] :choose
  #   number of r elements to n-choose-r from resulting array values passed
  #   to the `dblok` procedure; if the value is a floating-point number, then
  #   n-choose-r will occur twice: with the integer before the decimal point
  #   as well as the integer after it
  #
  # @param [Proc] dblok
  #   a block of code to execute resulting yielded datum against 
  #
  # @see Proc#call
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
  def derange_path(dopts, &dblok)
    incre = dopts['include'] ? dopts[:include] : nil
    excre = dopts['exclude'] ? dopts[:exclude] : nil
    achoo = dopts['choose'] ? dopts[:choose] : nil

    anurl = self.to_s

    anurl.chomp!('/')
    anurl.strip!

    raise(TypeError,'incre must be a kind of Regexp!') if incre and !incre.kind_of?(Regexp)
    raise(TypeError,'excre must be a kind of Regexp!') if excre and !excre.kind_of?(Regexp)
    raise(TypeError,'achoo must be a kind of Fixnum, Integer or Float!') if achoo and !(achoo.kind_of?(Fixnum) or achoo.kind_of?(Integer) or achoo.kind_of?(Float))
    raise(TypeError,'anurl must be a kind of String or URI!') if !(anurl.kind_of?(String) or anurl.kind_of?(URI))

    apath = self.kind_of?(URI) ? self.path : URI(self).path

    raise(EOFError,'anurl must have a path!') if apath.blank?

    asplt = apath.split('/') 
    anarr, asize = [], asplt.size - 1

    raise(RangeError,'anurl path depth must be greater than one and less than twenty-five!') if asize < 2 or asize > 24

    asplt[1 .. asize].derange.each do |a|
      anarr.concat(a)

      yield a if block_given?
    end

    block_given? ? anarr : anarr.to_enum
  end

  alias_method :derange_uris, :derange_path
end
