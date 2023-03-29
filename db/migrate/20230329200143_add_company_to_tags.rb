class AddCompanyToTags < ActiveRecord::Migration[7.0]
  def change
    add_reference :tags, :company_id, null: true, foreign_key: true
  end
end
