require 'coveralls'
Coveralls.wear!
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'meta_commit_ruby_support'
require 'rspec/mocks'
require 'support/contextual_node_creator'
RSpec.configure do |config|
  config.mock_framework = :rspec
end
