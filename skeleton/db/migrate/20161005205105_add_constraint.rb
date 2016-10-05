class AddConstraint < ActiveRecord::Migration
  def change
    remove_column :users, :session_token
    add_column :users, :session_token, :string, null: false
  end
end
