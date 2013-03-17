require 'rubygems'

class Password
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :password, :new_password

  validates :new_password,  :length => { :minimum => 4, :maximum => 50 },
                            :confirmation => true,
                            :presence => true
  
  def initialize(params={})
    params.each do |k, v|
      eval "@#{k.to_s} = (v.class == String) ? v.strip : v"
    end
  end  

  def persisted?
    false
  end
end
