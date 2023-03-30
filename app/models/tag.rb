class Tag < ApplicationRecord
  include PgSearch::Model
  include Share
  pg_search_scope :search, against: [:name], using: {tsearch: {prefix: true}}

  has_and_belongs_to_many :clients
  belongs_to :company

  validates :name, presence: true, uniqueness: {scope: :company_id}
end
