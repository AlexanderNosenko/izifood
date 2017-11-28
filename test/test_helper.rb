require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  load "#{Rails.root}/db/seeds/promotion.seeds.rb"

  # extend MiniTest::Spec::DSL
  # Rails.application.load_seed
  # Rake::Task["db:seed"].invoke


  include FactoryBot::Syntax::Methods
  FactoryBot.find_definitions
end
