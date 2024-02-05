class Contact < ApplicationRecord
  belongs_to :booking

  validates :birthdate, :email, presence: true
end
