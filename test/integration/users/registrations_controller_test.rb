require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  VALID_PASSWORD = "Valid!123"
  INVALID_PASSWORD = "WrongPassword!123"

  def setup
    @user = create(:user, password: VALID_PASSWORD, password_confirmation: VALID_PASSWORD)
    @other_user = create(:user, password: VALID_PASSWORD, password_confirmation: VALID_PASSWORD)
    sign_in @user
  end

  def teardown
    sign_out :user
  end

  test "allows user to update their own account" do
    patch user_registration_path, params: {
      user: {
        current_password: VALID_PASSWORD,
        first_name: "Updated",
        password: "",
        password_confirmation: ""
      }
    }

    @user.reload
    assert_equal "Updated", @user.first_name
    assert_redirected_to authenticated_root_path
  end

  test "prevents user from updating own account with wrong current password" do
    patch user_registration_path, params: {
      user: {
        current_password: INVALID_PASSWORD,
        first_name: "ShouldNotChange",
        password: "",
        password_confirmation: ""
      }
    }

    @user.reload
    refute_equal "ShouldNotChange", @user.first_name
    assert_response :unprocessable_entity
    assert_match "Current password is invalid", response.body
  end

  test "prevents guest user from updating user account" do
    sign_out :user
  
    patch user_registration_path, params: {
      user: {
        id: @user.id,
        first_name: "Malicious",
        current_password: VALID_PASSWORD
      }
    }
  
    @user.reload
    refute_equal "Malicious", @user.first_name
    assert_redirected_to new_user_session_path
    assert_equal "You need to sign in or sign up before continuing.", flash[:alert]
  end  
end
