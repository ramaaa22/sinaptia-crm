class Client < ApplicationRecord
  validates :name, :email, :location, presence: true
  validates :name, :email, uniqueness: true
end
