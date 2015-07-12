# encoding: utf-8
# 
# @author Derek Callaway <decal@ethernet.org>
#
# @since 0.8.0
#
# @version 0.8.5
#
class NilClass 
  # 
  # The `blank?' predicate method returns true for nil values
  #
  def blank?
    true
  end

  #
  # Method aliases names to be identified as `blank?` predicate code
  #
  # @since 0.8.5
  #
  alias_method :unset?, :blank?
  alias_method :isset?, :blank?
end
