class Property < ActiveRecord::Base
	belongs_to :user
	belongs_to :neighborhood
	belongs_to :agent
	has_many :appointments, dependent: :destroy
	has_many :adds, dependent: :destroy
	has_many :comments, as: :commentable, dependent: :destroy
	validates :street, :number, :unit, :owned_by, :user_id, :neighborhood_id, presence: true
	validates :number, numericality: true
end
