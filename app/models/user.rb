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
  validate :validate_signup_code
  
  VALID_SIGNUP_CODES = ["HAPPYNEWYEAR"] 
  
  before_save :encrypt_password
  
  private
  
  def validate_signup_code
    unless persisted?
      unless VALID_SIGNUP_CODES.include? signup_code
        return errors.add(:signup_code, t("message.signup_code_invalid"))
      end
      if User.find_by_signup_code(signup_code).present?
        return errors.add(:signup_code, t("message.signup_code_used"))
      end
    end
  end
  
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
