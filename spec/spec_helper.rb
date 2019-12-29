# frozen_string_literal: true

require 'bundler/setup'
require 'byebug'
require 'autotask_ruby'
require 'awesome_print'
require 'webmock/rspec'
require 'dotenv'

WebMock.disable_net_connect!
# WebMock.allow_net_connect!

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  # config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

Dotenv.load