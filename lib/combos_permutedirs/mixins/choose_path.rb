require'uri'

#
# @author Derek Callaway <decal@ethernet.org>
#
# @version 0.8.5
#
# @since 0.8.5
#
module Combinatorics::PermuteDirs::Mixin
  #
  # @param [Integer] csize
  #   "n-choose-r" where r equals `csize` and n equals total path depth
  #
  # @param [Array] clist
  #   only return results for path names matching order of String's in `clist` Array
  #
  # @raise [TypeError] 
  #   `caurl` must be a `String` when passed to initialize
  #
  # @raise [EOFError]
  #   `caurl` must have a slash after the Hostname or IPAddr component of the URI String
  #
  # @raise [ArgumentError]
  #   `csize` and `clist` must not be blank!
  #
  # @raise [NameError]
  #   `caurl` must have a directory depth of more than one
  #
  # @yield [pathlist] Array<Array<String>>
  #   The given block will be passed two-dimensional Arrays of recombinant 
  #   directory path names
  #
  # @yieldparam [String] path 
  #   The directory names as a unique ordering in a `path`
  #
  # @return [Array]
  #   An Array containing Object's of type String is returned
  #
  # @note If no block is passed as input, an Enumerator Object is returned
  #
  # @see Enumerator
  #
  # @see URI#path
  #
  # @example 'http://google.com/a/b/c/d/e/f'.choose_uris(3,["a","c"]) {|x| x.each {|y| y.inspect}}
  #   => [["a", "c", "b"], ["a", "c", "d"], ["a", "c", "e"], ["a", "c", "f"]]
  #
  def choose_path(csize, clist, &cblok)
    cpath, caurl = '', self.to_s.dup

    caurl.chomp!('/')
    caurl.strip!

    raise(ArgumentError,'csize and clist cannot be blank (e.g. nil or empty)!') if csize.blank? or clist.blank?
    raise(TypeError,'csize must be a kind of Integer or Fixnum!') if !(csize.kind_of?(Integer) or csize.kind_of?(Fixnum))
    raise(RangeError,'csize must be a whole number (i.e. positive and non-zero)!') if csize <= 0
    raise(RangeError,'csize must be less than the size of clist!') if csize < clist.size
    raise(TypeError,'clist must be a kind of Array!') if !clist.kind_of?(Array)
    raise(TypeError,'caurl must be a kind of String or URI!') if !(caurl.kind_of?(String) or caurl.kind_of?(URI))

    cpath = self.class.kind_of?(URI) ? self.path : URI(self).path

    raise(EOFError,'caurl must not have a blank path!') if cpath.blank?

    csplt = cpath.split('/')
    cnarr, cnsiz = [], csplt.size - 1

    raise(RangeError,'clist path depth must be greater than one!') if cnsiz < 2 

    csplt[1 .. cnsiz].choose(csize).each do |c|
      caobj = c.permute(c.size).to_a # compute k-permutations where k = c.size

      #STDERR.puts("caobj: #{caobj}")

      caobj.each do |x|
        if x[0 .. clist.size - 1].eql?(clist)
          cnarr << x

          yield x if block_given?
        end
      end
    end

    block_given? ? cnarr : enum_for(:String, cnarr)
  end

  alias_method :choose_uris, :choose_path
  alias_method :nchooser_path, :choose_path
  alias_method :nchooser_uris, :choose_path
end
