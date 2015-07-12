# 
# @author Derek Callaway <decal@ethernet.org>
#
# @since 0.8.0
#
# @version 0.8.5
#
class TrueClass
  #
  # The `blank?' predicate method returns false for true values
  #
  def blank?
    false
  end
end
