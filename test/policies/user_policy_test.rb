require "test_helper"

class UserPolicyTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    @other_user = create(:user)
  end

  test "user can update their own account" do
    assert UserPolicy.new(@user, @user).update?
  end

  test "user cannot update another user's account" do
    refute UserPolicy.new(@user, @other_user).update?
  end
end
