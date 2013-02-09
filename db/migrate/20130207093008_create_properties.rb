class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :city
      t.string :suburb
      t.string :street
      t.string :postcode
      t.integer :n_bathroom
      t.integer :n_room
      t.string :note

      t.timestamps
    end
  end
end
