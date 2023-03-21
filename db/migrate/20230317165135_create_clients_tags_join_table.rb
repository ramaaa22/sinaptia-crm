class CreateClientsTagsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :clients, :tags
  end
end
