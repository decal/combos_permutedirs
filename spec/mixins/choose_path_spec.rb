require'spec_helper'
require'combos_permutedirs'

describe String do
  subject { 'http://google.com/a/b/c/d/e' }

  it 'should return an Enumerator when no block is passed' do
    subject.choose_path(2, ['a','b','c']).class.should == Enumerator
  end

  it 'should alias choose_path to choose_uris' do
    should respond_to(:choose_uris)
  end

  it 'should alias choose_path to nchooser_path' do
    should respond_to(:nchooser_path)
  end

  it 'should alias choose_path to nchooser_uris' do
    should respond_to(:nchooser_uris)
  end
end
