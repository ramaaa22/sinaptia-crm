class AddCompanyToClients < ActiveRecord::Migration[7.0]
  def change
    add_reference :clients, :company_id, null: true, foreign_key: true
  end
end
