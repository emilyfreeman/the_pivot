require "test_helper"

class UserSeesFarmerIndexTest < ActionDispatch::IntegrationTest

  def setup
    # user = User.create(first_name: "John",
    #                    last_name: "Slota",
    #                    username: "john",
    #                    password: "password",
    #                    role: 1)
    #
    # store = user.stores.create(name: "Adam's Apples",
    #                    status: "approved")
    visit '/farmers'
  end

  test 'user visits farmer index page' do
    setup
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
