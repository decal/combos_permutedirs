require'spec_helper'
require'combos_permutedirs'

describe String do
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
