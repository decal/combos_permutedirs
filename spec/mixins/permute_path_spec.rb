require'spec_helper'
require'combos_permutedirs'

describe String do
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
