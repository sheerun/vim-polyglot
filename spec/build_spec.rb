$plugin_path = File.expand_path('../..', __FILE__)

describe 'build script' do
  it 'should run and return success code' do
    Dir.chdir($plugin_path)
    expect(system('bash ./build')).to be_true
  end
end
