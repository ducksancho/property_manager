class RemoveNoteFromProperty < ActiveRecord::Migration
  def up
    remove_column :properties, :note
  end

  def down
    add_column :properties, :note, :string
  end
end
