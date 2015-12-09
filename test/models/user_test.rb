require "test_helper"

class UserTest < ActiveSupport::TestCase
  binding.pry
  roles.exists?(name: "registered_user")

end
