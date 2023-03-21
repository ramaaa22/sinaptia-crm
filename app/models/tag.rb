class Tag < ApplicationRecord
  has_and_belongs_to_many :clients

  validates :name, uniqueness: true
end
