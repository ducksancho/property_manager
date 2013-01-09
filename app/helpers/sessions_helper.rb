module SessionsHelper
  def current_user
    if session[:id].present?
      @current_user ||= User.find(session[:id])
    else
      @current_user = nil
    end
  end
  def login(session_model)
    if session_model.valid?
      session[:id] = session_model.user.id
      true
    else
      false
    end
  end
  def logout
    session.delete(:id)
  end
end