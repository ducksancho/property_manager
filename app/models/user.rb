class User < ActiveRecord::Base
  attr_accessor :password, :edit_password
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :f_name,    :presence => true
  validates :l_name,    :presence => true
  validates :email,     :format   => { :with => email_regex }
  validates :password,  :length => { :minimum => 4, :maximum => 50 },
                        :confirmation => true,
                        :allow_blank => true
  validates :password, :presence => true, :if => :password_required?
  before_save :encrypt_password
  
  
  private
  
  def password_required?
    !persisted? || edit_password.present?
  end
  def encrypt_password
    if password_required?
      self.encryption_salt = make_salt
      self.encrypted_password = encrypt(password) 
    end
  end
  def make_salt
    secure_hash("#{Time.new.utc}::#{password}")
  end
  def encrypt(string)
    secure_hash("#{encryption_salt}::#{string}")
  end
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
