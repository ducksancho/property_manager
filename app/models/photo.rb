class Photo < ActiveRecord::Base
  belongs_to :photoable, :polymorphic => true

  mount_uploader :photo, PhotoUploader
  attr_accessor :photo_delete
  attr_accessible :photo, :photo_delete
end
