class AddSignupCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :signup_code, :string
  end
end
