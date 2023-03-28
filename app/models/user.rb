class User < ApplicationRecord
  APPROVED_DOMAINS = ["sinaptia.dev"]

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :notes
  has_many :identities

  validates :email, presence: true, if: :domain_check

  enum role: {default: 0, admin: 1}

  private

  def domain_check
    unless APPROVED_DOMAINS.any? { |word| email.end_with?(word) }
      errors.add(:email, "is not from a valid domain")
    end
  end
end
