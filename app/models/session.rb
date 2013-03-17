require 'rubygems'

class Session
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :email, :password
  
  validate :validate_user
  
  def initialize(params={})
    self.email = params[:email]
    self.password = params[:password]
  end
    
  def validate_user
    user_to_check = User.find_by_email(email)
    if user_to_check && user_to_check.valid_password?(password)
      @user = user_to_check
    else
      errors.add(:base, I18n.t("message.incorrect_email_or_password"))
    end
  end
  # use it after validate
  def user
    @user
  end
  
  def persisted?
    false
  end
end