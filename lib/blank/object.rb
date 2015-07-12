require 'uri'

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
end
