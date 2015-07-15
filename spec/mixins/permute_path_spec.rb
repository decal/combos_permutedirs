require'spec_helper'
require'combos_permutedirs'

describe String do
  subject { String.new('http://google.com/a/b/c') }

  it 'should return an Enumerator when no block is passed' do
    subject.permute_uris.class.should == Enumerator
  end

  it 'should return an Array when a block is passed' do
    subject.permute_uris { |x| x }.class.should == Array
  end

  it 'should count 8 elements during processing' do
    i = 0
    subject.permute_uris { |x| i += 1 }
    i.should == 8
  end

  it 'should alias permute_path to permute_uris' do
    should respond_to(:permute_uris)
  end

  it 'should alias permute_path to permpowset_path' do
    should respond_to(:permpowset_path)
  end

  it 'should alias permute_path to permpowset_uris' do
    should respond_to(:permpowset_uris)
  end

  it 'should alias permute_path to permutepowerset_uris' do
    should respond_to(:permutepowerset_uris)
  end

  it 'should alias permute_path to permutepowerset_path' do
    should respond_to(:permutepowerset_path)
  end
end
