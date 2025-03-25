class Users::RegistrationsController < Devise::RegistrationsController
  layout 'form_only'

  before_action :authenticate_user!
  before_action :set_user, only: [:update, :edit, :destroy]

  def update
    authorize @user

    if update_user
      redirect_to after_update_path_for(@user), notice: "Account updated."
    else
      clean_up_passwords(@user)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = resource
  end

  def update_user
    if update_resource(@user, account_update_params)
      send_password_change_notification_if_needed
      bypass_sign_in(@user)
      true
    else
      false
    end
  end

  def send_password_change_notification_if_needed
    @user.send_password_change_notification! if password_changed?
  end

  def password_changed?
    account_update_params[:password].present?
  end
end
