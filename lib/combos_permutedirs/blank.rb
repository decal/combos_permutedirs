require 'uri'

# 
# @author Derek Callaway <decal@ethernet.org>
#
# @since 0.8.0
#
# @version 0.8.0
#
class FalseClass
  # 
  # The `blank?' predicate method returns true for false values
  #
  def blank?
    true
  end
end

class TrueClass
  #
  # The `blank?' predicate method returns false for true values
  #
  def blank?
    false
  end
end

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
    raise(TypeException,'Object must be a kind of String!') if self.class.kind_of?(String)

    URI(self).path
  end
end
