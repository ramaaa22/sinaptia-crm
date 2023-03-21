class Client < ApplicationRecord
  has_many :notes, dependent: :delete_all
  has_and_belongs_to_many :tags

  validates :name, :email, :location, presence: true
  validates :name, :email, uniqueness: true
end
