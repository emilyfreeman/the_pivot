require "test_helper"

class UserSeesFarmerIndexTest < ActionDispatch::IntegrationTest

  def setup
    visit '/farmers'
  end

  test 'user visits farmer index page' do
    skip
    assert_equal farmers_path, current_path
    within(".farmers") do
      assert page.has_content?("Adam's Apples")
      assert page.has_content?("Owner Adam")     ##change
    end

  end

  # test "user can click on a farmer and is taken to the show page of that farmer" do
  #   skip
  #   click_on "Adam's Apples"
  #   assert_equal  store_path(), current_path
  # end

end
