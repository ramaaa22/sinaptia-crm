module Share
  extend ActiveSupport::Concern

  included do
    scope :per_company, ->(company) { where("company_id = ?", company) }
  end

  def belongs_company?(id)
    company.id == id
  end
end
