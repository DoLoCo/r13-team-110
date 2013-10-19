class User::ParameterSanitizer < Devise::ParameterSanitizer

  def sign_up
    default_params.permit(*attributes)
  end

  def account_update
    default_params.permit(*attributes)
  end

private

  def attributes
    [
      :name,
      :email,
      :password,
      :password_confirmation
    ]
  end

end