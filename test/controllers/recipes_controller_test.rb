require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    host! "izifood.local"
    @user = FactoryBot::create(:user_with_membership)
    @recipe = FactoryBot::create(:recipe)

    sign_in @user
  end

  # test "should get index" do
  #   get recipes_url
  #   assert_response :success
  # end

  # test "should show recipe" do
  #   get recipe_url(@recipe)
  #   assert_response :success
  # end
end
