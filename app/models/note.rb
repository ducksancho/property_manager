class Note < ActiveRecord::Base
  belongs_to :notable, :polymorphic => true
  
  attr_accessible :note
end
