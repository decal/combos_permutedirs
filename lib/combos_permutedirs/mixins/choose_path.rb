# encoding: utf-8

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
  # @raise [EOFError]
  #   `caurl` must have a slash after the Hostname or IPAddr component of the URI String
  #
  # @raise [ArgumentError]
  #   `csize` cannot be blank
  #
  # @raise [TypeError]
  #   `csize` must be a kind of Integer of Fixnum
  #
  # @raise [RangeError]
  #   `csize` must be non-zero and non-negative
  #
  # @raise [TypeError]
  #   `clist` must be a kind of Array if it's not nil
  #
  # @raise [TypeError]
  #   `caurl` must be a kind of String or URI
  #
  # @yield [pathlist] Array<Array<String>>
  #   The given block will be passed two-dimensional Arrays of recombinant 
  #   directory path names
  #
  # @yieldparam [String] path 
  #   The directory names as a unique ordering in a `path`
  #
  # @return [Array]
  #   A non-empty Array containing String type Objects is typically returned
  #
  # @note If no block is passed as input, an Enumerator Object is returned
  #
  # @see Enumerator
  #
  # @see URI#path
  #
  # @example 'http://google.com/a/b/c/d/e/f'.choose_uris(3,["a","c"]) { |x| x.each { |y| y } }
  #   => [["a", "c", "b"], ["a", "c", "d"], ["a", "c", "e"], ["a", "c", "f"]]
  #
  def choose_path(csize, clist, &cblok)
    cpath, caurl = '', self.to_s
    clsiz = clist ? clist.size - 1 : 0

    caurl.chomp!('/')
    caurl.strip!

    raise(ArgumentError,'csize cannot be blank!') if csize.blank? 
    raise(TypeError,'csize must be a kind of Integer or Fixnum!') if !(csize.kind_of?(Integer) or csize.kind_of?(Fixnum))
    raise(RangeError,'csize must be non-zero and non-negative!') if csize <= 0
    raise(TypeError,'clist must be a kind of Array if not NilClass!') if !(clist.nil? or clist.kind_of?(Array))
    raise(TypeError,'caurl must be a kind of String or URI!') if !(caurl.kind_of?(String) or caurl.kind_of?(URI))

    cpath = self.kind_of?(URI) ? self.path : URI(self).path

    raise(EmptyError,'caurl must not have a blank path!') if cpath.blank?

    cnarr, csplt = [], cpath.split('/')
    cnsiz = csplt.size - 1

    raise(RangeError,'csize must be less than or equal to clist path depth!') if csize > clsiz
    raise(RangeError,'csize must be non-zero and non-negative!') if csize < 1
    raise(RangeError,'clist path depth must be non-zero and non-negative!') if cnsiz < 1

    csplt[1 .. cnsiz].choose(csize).each do |c|
      begin
        caobj = c.permute(c.size).to_a # compute k-permutations where k = c.size

        warn("*%* caobj: #{caobj} c: #{c}") if Config.debug

        if clist and clsiz and !clsiz.zero?
          caobj.each do |x|
            if x[0 .. clsiz].eql?(clist)
              cnarr << x

              yield x if block_given?
            end
          end
        else
          caobj.each do |y|
            cnarr << y 

            yield y if block_given?
          end
        end
      rescue Exception => e
        warn("*!* #{e} #{e.backtrace_locations.join(' ')}") if Config.debug
      end
    end

    warn('choose_path return Array is empty!') if cnarr.empty? and Config.debug

    block_given? ? cnarr : cnarr.to_enum
  end

  alias_method :choose_uris, :choose_path
  alias_method :nchooser_path, :choose_path
  alias_method :nchooser_uris, :choose_path
end
