class Client < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:name, :email, :location], associated_against: {tags: [:name]}, using: {tsearch: {prefix: true}}

  has_many :notes
  has_and_belongs_to_many :tags
  belongs_to :company

  validates :name, :email, :location, presence: true
  validates :name, :email, uniqueness: {scope: :company_id}
  validates :email, email: true

  scope :per_company, ->(company) { where("company_id = ?", company) }

  def belongs_company?(id)
    company.id == id
  end
end
