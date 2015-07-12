# encoding: utf-8

require'uri'

# 
# @author Derek Callaway <decal@ethernet.org>
#
# @since 0.8.0
#
# @version 0.8.5
#
class Object
  #
  # The `blank?' predicate method returns true for empty or nil Objects
  #
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end

  #
  # Returns the path portion of a URI for Objects that are a kind of String
  #
  def path
    URI(self.to_s).path
  end

  #
  # One or more method aliases to be identified as `blank?` predicate code
  #
  # @since 0.8.5
  #
  alias_method :unset?, :blank?
  alias_method :isset?, :blank?

  #
  # One or more method aliases for code statements defined as `path` 
  #
  # @since 0.8.5
  #
  alias_method :folder, :path
  alias_method :fulldir, :path
  alias_method :dir, :path
  alias_method :directory, :path
  alias_method :dirname, :path
  alias_method :dname, :path
end
