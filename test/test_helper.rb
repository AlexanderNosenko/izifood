require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails"
# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
require "minitest/pride"

# https://github.com/kern/minitest-reporters#usage
require "minitest/reporters"

# http://chriskottom.com/blog/2014/06/dress-up-your-minitest-output/
Minitest::Reporters.use! [
  # Use either DefaultReporter (dots) or SpecReporter (verbose)
  Minitest::Reporters::DefaultReporter.new({
    color: true,
    slow_count: 5
  }),
  # Minitest::Reporters::JUnitReporter.new
]
class ActiveSupport::TestCase
  # Rails.application.load_seed
  # Rake::Task["db:seed"].invoke
  load "#{Rails.root}/db/seeds/promotion.seeds.rb"

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add helper methods like subject, let, before/after…
  # https://docs.ruby-lang.org/en/2.1.0/MiniTest/Spec/DSL.html
  extend MiniTest::Spec::DSL

  # https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md#minitest-rails
  include FactoryBot::Syntax::Methods
  FactoryBot.find_definitions

  include Devise::Test::IntegrationHelpers

  # def sign_in(user)
  #   if user.nil?
  #     allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
  #     allow(controller).to receive(:current_user).and_return(nil)
  #   else
  #     allow(request.env['warden']).to receive(:authenticate!).and_return(user)
  #     allow(controller).to receive(:current_user).and_return(user)
  #   end
  # end

end