class AddAcceptedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :accepted, :boolean
  end
end
