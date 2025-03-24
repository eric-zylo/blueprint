require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = build(:user)
  end

  test "should save user with valid password" do
    assert @user.valid?
  end

  test "should not save user without a digit" do
    @user.password = @user.password_confirmation = "NoDigits!"
    assert_not @user.valid?
    assert_includes @user.errors[:password], "must include at least one digit"
  end

  test "should not save user without a lowercase letter" do
    @user.password = @user.password_confirmation = "NOLOWER1!"
    assert_not @user.valid?
    assert_includes @user.errors[:password], "must include at least one lowercase letter"
  end

  test "should not save user without an uppercase letter" do
    @user.password = @user.password_confirmation = "noupper1!"
    assert_not @user.valid?
    assert_includes @user.errors[:password], "must include at least one uppercase letter"
  end

  test "should not save user without a special character" do
    @user.password = @user.password_confirmation = "NoSpecial1"
    assert_not @user.valid?
    assert_includes @user.errors[:password], "must include at least one special character"
  end

  test "should not save user with password shorter than 8 characters" do
    @user.password = @user.password_confirmation = "Short1!"
    assert_not @user.valid?
    assert_includes @user.errors[:password], "is too short (minimum is 8 characters)"
  end

  test "should not save user without first name" do
    user = FactoryBot.build(:user, first_name: nil)
    assert_not user.save, "Saved the user without a first name"
  end

  test "should not save user without last name" do
    user = FactoryBot.build(:user, last_name: nil)
    assert_not user.save, "Saved the user without a last name"
  end

  test "should save user with valid first name and last name" do
    user = FactoryBot.build(:user, first_name: "John", last_name: "Doe")
    assert user.save, "Failed to save the user with valid first name and last name"
  end
end
