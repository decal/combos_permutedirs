class Float
  def combos_cast!
    aflot = self
    one, two = 0, 0

    one = self.to_i
    two = (self - one) * 10
    
    raise(RangeError,'number after decimal must be greater than or equal to number before!') if one > two

    self = one..two
  end
end
