class User < ActiveRecord::Base
  attr_accessor :password, :edit_password
  attr_accessible :f_name, :l_name, :email, :password, :password_confirmation, :edit_password, :signup_code
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :f_name,    :presence => true
  validates :l_name,    :presence => true
  validates :email,     :format   => { :with => email_regex }
  validates :password,  :length => { :minimum => 4, :maximum => 50 },
                        :confirmation => true,
                        :allow_blank => true
  validates :password, :presence => true, :if => :password_required?
  
  VALID_SIGNUP_CODES = ["HAPPYNEWYEAR"]
  
  before_save :encrypt_password
  
  # Always check before create
  def signup_code_error    
    return I18n.t("message.no_signup_without_signup_code")  if signup_code.blank?
    return I18n.t("message.signup_code_invalid")            unless VALID_SIGNUP_CODES.include? signup_code
    return I18n.t("message.signup_code_used")               if User.find_by_signup_code(signup_code).present?
    nil
  end
  
  private
    
  def password_required?
    !persisted? || edit_password.present?
  end
  def encrypt_password
    if password_required?
      self.salt = make_salt
      self.encrypted_password = encrypt(password) 
    end
  end
  def make_salt
    secure_hash("#{Time.new.utc}::#{password}")
  end
  def encrypt(string)
    secure_hash("#{salt}::#{string}")
  end
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
