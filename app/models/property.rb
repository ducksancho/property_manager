class Property < ActiveRecord::Base
  attr_accessible :city, :n_bathroom, :n_room, :note, :postcode, :street, :suburb
end
