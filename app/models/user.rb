class User < ApplicationRecord
  include Discard::Model
  include PgSearch::Model
  pg_search_scope :search, against: [:email, :first_name, :last_name], using: {tsearch: {prefix: true}}

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :notes
  has_many :identities
  belongs_to :company, optional: true

  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true

  enum role: {default: 0, admin: 1}

  def belongs_company?(id)
    company.id == id
  end

  def active_for_authentication?
    super && !discarded?
  end

  def has_company?
    !company.nil? && accepted
  end

  private

  def domain_check
    unless APPROVED_DOMAINS.any? { |word| email.end_with?(word) }
      errors.add(:email, "is not from a valid domain")
    end
  end
end
