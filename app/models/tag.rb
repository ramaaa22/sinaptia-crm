class Tag < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:name], using: {tsearch: {prefix: true}}

  has_and_belongs_to_many :clients

  validates :name, presence: true, uniqueness: true
end
