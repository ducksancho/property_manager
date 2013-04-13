class AddCreatorIdToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :creator_id, :integer
  end
end
