require 'capybara/rspec'
ENV['RACK_ENV'] ||= 'test'

APP_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'../')
Dir["#{APP_DIR}/spec/support/**/*.rb"].each { |f| require f }

require "#{APP_DIR}/address_api.rb"
Capybara.app = AddressApi

RSpec.configure do |config|
  config.profile_examples = 10
  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
