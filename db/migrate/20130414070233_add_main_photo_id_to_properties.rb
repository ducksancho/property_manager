class AddMainPhotoIdToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :main_photo_id, :integer
  end
end
