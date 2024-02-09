class Contact < ApplicationRecord
  belongs_to :booking

  validates :birthdate, :email, :name, :phone, :country, presence: true
  validate :birthdate_at_least_18_years_ago
  validate :valid_email_format
  validate :valid_phone_format

  private

  def birthdate_at_least_18_years_ago
    if birthdate.present? && birthdate > 18.years.ago.to_date
      errors.add(:birthdate, "must be at least 18 years ago")
    end
  end

  def valid_email_format
    if email.present? && !(email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
      errors.add(:email, "is not a valid email")
    end
  end

  def valid_phone_format
    if phone.present? && !(phone =~ /\A\d{10}\z/)
      errors.add(:phone, "is not a valid phone number")
    end
  end
end
