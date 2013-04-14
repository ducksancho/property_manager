class Property < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  has_many :photos, :as => :photoable, :dependent => :destroy
  has_one :note, :as => :notable, :dependent => :destroy # Use max one note
  has_one :main_photo, :class_name => "Photo"
  
  accepts_nested_attributes_for :note, :photos
  attr_accessor :main_photo_index
  attr_accessible :city, :n_bathroom, :n_room, :postcode, :street, :suburb, :note_attributes, :photos_attributes, :main_photo_id, :main_photo_index
  
  before_save :remove_empty_note, :remove_empty_photo
  
  def prepare_note_for_form
    self.note_attributes = {:note => nil}  if note.blank?
  end
  def prepare_photos_for_form
    self.photos.reload
    self.photos.build
  end
  def remove_empty_note
    note.destroy if note.present? && note.note.blank?
  end
  def remove_empty_photo
    self.photos.each do |photo|
      photo.destroy if photo.photo.blank?
    end
  end
end
