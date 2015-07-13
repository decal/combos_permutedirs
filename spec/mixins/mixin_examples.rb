require'spec_helper'
require'combos_permutedirs/mixins'

shared_examples_for 'Combinatorics::PermuteDirs::Mixin' do
  it 'String#permute_path should return an Enumerator when no block is passed' do
    'http://google.com/a/b/c'.permute_path.class.should == Enumerator
  end

  it 'String#choose_path should return an Enumerator when no block is passed' do
    'http://google.com/a/b/c'.choose_path.class.should == Enumerator
  end

  it 'String#permute_path should return an Array when a block is passed' do
    'http://google.com/a/b/c'.permute_path{|x| x.inspect}.class.should == Array
  end

  it 'String#choose_path should return an Array when a block is passed' do
    'http://google.com/a/b/c'.choose_path{|x| x.inspect}.class.should == Array
  end
end
