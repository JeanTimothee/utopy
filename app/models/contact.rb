class Contact < ApplicationRecord
  belongs_to :booking

  before_save :update_phone

  validates :birthdate, :email, :first_name, :last_name, :phone, :country, presence: true
  validate :birthdate_at_least_18_years_ago
  validate :valid_email_format
  # validate :valid_phone_format

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

  def update_phone
    unless self.phone[0] == "+" || self.phone[0..1] == "00"
      self.phone = "00" + ISO3166::Country.find_country_by_any_name(self.country).country_code + self.phone.gsub(/\D/, '').sub!(/^0+/, '')
    end
  end
end
