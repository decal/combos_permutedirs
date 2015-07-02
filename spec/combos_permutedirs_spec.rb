require 'spec_helper'

describe Combinatorics::PermuteDirs do
  it 'should have a VERSION constant' do 
    not subject.const_get('VERSION').should_not be_empty
  end
end
