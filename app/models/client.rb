class Client < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:name, :email, :location], associated_against: {tags: [:name]}, using: {tsearch: {prefix: true}}

  has_many :notes, dependent: :delete_all
  has_and_belongs_to_many :tags

  validates :name, :email, :location, presence: true
  validates :name, :email, uniqueness: true
  validates :email, email: true
end
