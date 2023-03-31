class User < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: [:email, :first_name, :last_name], using: {tsearch: {prefix: true}}

  APPROVED_DOMAINS = ["sinaptia.dev"]

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :notes
  has_many :identities
  belongs_to :company

  validates :email, presence: true, if: :domain_check
  validates :first_name, :last_name, presence: true
  validates :company, presence: true

  enum role: {default: 0, admin: 1}

  def belongs_company?(id)
    company.id == id
  end

  private

  def domain_check
    unless APPROVED_DOMAINS.any? { |word| email.end_with?(word) }
      errors.add(:email, "is not from a valid domain")
    end
  end
end
