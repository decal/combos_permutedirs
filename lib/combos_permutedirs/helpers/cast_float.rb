class Float
  def combos_cast!
    aflot = self
    one, two = 0, 0

    one = aflot.to_i
    two = (aflot - one) * 10
    
    raise(RangeError,'number after decimal must be greater than or equal to number before!') if one > two

    self.assign(one.two)
  end
end
