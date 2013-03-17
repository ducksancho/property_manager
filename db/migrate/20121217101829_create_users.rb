class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :f_name
      t.string :l_name
      t.string :email
      t.string :salt
      t.string :encrypted_password

      t.timestamps
    end
  end
end
