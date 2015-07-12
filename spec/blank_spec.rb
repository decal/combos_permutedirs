require 'spec_helper'
require 'combos_permutedirs/blank'

describe 'FalseClass#blank?' do
  it 'should return false for blank? method invocation' do
    false.blank?.should == true
  end
end

describe 'TrueClass#blank?' do
  it 'should return false for blank? method invocation' do
    true.blank?.should == false
  end
end

describe 'String#blank?' do
  it 'should return false for blank? method invocation on non-zero size String' do
    s = String.new('123')

    s.blank?.should == false
  end

  it 'should return true for blank? method invocation on zero size String' do
    s = String.new('')

    s.blank?.should == true
  end
end
