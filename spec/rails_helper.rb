# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'spec_helper'
require 'shoulda/matchers'
require 'rspec/collection_matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  #config.include ApplicationHelper
  #config.include ControllersHelper
  #config.include UsersHelper
  #config.extend ControllerMacros, :type => :controller
  config.include Devise::TestHelpers, type: :controller

  config.include FactoryGirl::Syntax::Methods

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.raise_errors_for_deprecations!

  config.mock_with :mocha

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

end
