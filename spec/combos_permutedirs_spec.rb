require'spec_helper'

describe Combinatorics::PermuteDirs do
  it 'should have a VERSION constant' do 
    not subject.const_get('VERSION').should_not be_empty
  end

  it 'should resolve scope to a Mixin sub-namespace' do
    subject::Mixin.class.should == Module
  end
end
