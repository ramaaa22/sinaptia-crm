class Note < ApplicationRecord
  belongs_to :client
  belongs_to :user

  validates :body, :client, presence: true
end
