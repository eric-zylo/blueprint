class Users::RegistrationsController < Devise::RegistrationsController
  layout 'form_only'

  def update
    super
  end
end
