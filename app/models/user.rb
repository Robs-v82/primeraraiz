class User < ActiveRecord::Base
	has_many :properties
	has_many :appointments, through: :properties 
	has_secure_password
	VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true
	validates :mobile_phone, length: { is: 10 }, numericality: true, allow_nil: true
	validates :other_phone, length: { is: 10 }, numericality: true, allow_nil: true
	validates :email, uniqueness:  {case_sensitive: false }
	validates :email, format:  {with: VALID_EMAIL_REGEX }
end
