require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'user with valid email should be valid' do
    user = User.new(email: 'test@test.org', password_digest: 'password')
    assert user.valid?
  end

  test 'user with invalid email should be invalid' do
    user = User.new(email: 'email@', password_digest: 'password')
    assert_not user.valid?
  end

  test 'user with taken email should be invalid' do
    other_user = users(:one)
    user = User.new(email: other_user.email, password_digest: 'password')
    assert_not user.valid?
  end
end
