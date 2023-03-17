class Client < ApplicationRecord
  has_many :notes, dependent: :delete_all
  validates :name, :email, :location, presence: true
  validates :name, :email, uniqueness: true
end
