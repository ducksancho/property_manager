module SignupCodeHelper
  def redirect_on_invalid_signup_code(user)
    signup_code_error = user.signup_code_error
    redirect_to(root_path, :alert => signup_code_error) if signup_code_error
  end
end
