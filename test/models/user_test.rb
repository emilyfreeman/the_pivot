require "test_helper"

class UserTest < ActiveSupport::TestCase
  valid_params = { username: "beyonce",
                   password: "putaringonit" }

  test "it is valid with correct params" do
    user = User.new(valid_params)
    assert user.valid?
  end

  test "it is invalid without username" do
    user = User.new(username: "",
                    password: "password")
    assert user.invalid?
  end

  test "it is invalid without password" do
    user = User.new(username: "Dr. Dre")
    assert user.invalid?
  end

  test "username must be unique" do
    user = User.create(valid_params)
    same_user = User.new(valid_params)

    assert same_user.invalid?
  end
end
