class Agent < ActiveRecord::Base
	has_many :properties
	has_many :appointments, through: :properties
	has_many :comments, as: :commentable
	has_secure_password
end
