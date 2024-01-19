class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :birthdate, :first_name, :last_name, :phone, :country

  validates :birthdate, :first_name, :last_name, :phone, :country, presence: true
end
