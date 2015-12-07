require 'test_helper'

class UserCanViewCategoriesIndexTest < ActionDispatch::IntegrationTest

  def setup
    12.times do |i|
      Category.create!(name: "Category #{i}")
    end
  end

  test "user can view the categories index page" do
    visit categories_path

    within(".categories") do
      12.times do |i|
        assert page.has_content?("Category #{i}")
      end
    end
  end
end
