require 'vimrunner'
require 'vimrunner/rspec'

$plugin_path = File.expand_path('../..', __FILE__)

Vimrunner::RSpec.configure do |config|
  config.reuse_server = false

  # Decide how to start a Vim instance. In this block, an instance should be
  # spawned and set up with anything project-specific.
  config.start_vim do
    vim = Vimrunner.start

    # Setup your plugin in the Vim instance
    vim.add_plugin($plugin_path)

    # The returned value is the Client available in the tests.
    vim
  end
end
