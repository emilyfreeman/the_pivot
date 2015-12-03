require 'test_helper'

class UserCanViewStoreItemsTest < ActionDispatch::IntegrationTest

  def setup
    store = Store.create!(name: "Slota's farm",
                          bio: "some cool bio")
  end

  test "user can view specific store items index" do
    visit '/slota-s-farm'

    # within(".profile-pic") do
    #   assert page.has_css?("img[src*='#{store.image_url}']")
    # end

    within(".bio") do
      assert page.has_content?("some cool bio")
    end

    within(".greeting") do
      assert page.has_content?("Slota's farm")
    end

    within(".categories") do
      assert page.has_content?("")
    end

    within(".items") do
      assert page.has_content?("")
    end
  end
end
