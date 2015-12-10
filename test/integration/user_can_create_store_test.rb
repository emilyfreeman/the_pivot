require "test_helper"

class UserCanCreateStoreTest < ActionDispatch::IntegrationTest

  def setup
    create_user
    login_user
    @order = @user.orders.create(status:"completed", total_price: 123, address: "203, Main St, Denver Co. 80223")
    @order2 = @user.orders.create(status:"completed", total_price: 13, address: "789, Queen St, Denver Co. 80223")
  end

  test "a registered user can create a store" do
    click_link "Interested in your own business?!"


    assert new_store_path, current_path

    fill_in "Name", with: "name"
    fill_in "Bio",  with: "bio"
    click_button "Create Account"

    assert page.has_content?("Emily you have submitted business name. Please wait while we review your business")

    refute page.has_content?("Interested in your own business?!")
  end

  test "a registered user tries bad info" do
    click_link "Interested in your own business?!"

    assert new_store_path, current_path

    fill_in "Name", with: nil
    fill_in "Bio",  with: nil
    click_button "Create Account"

    assert page.has_content?("Name can't be blank, Slug can't be blank")
  end
end
