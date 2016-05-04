class MustBeFuture < ActiveModel::Validator
  def validate(record)
    if record.date < Time.now
      record.errors[:base] << "Por favor, agende una fecha a partir de mañana"
    end
  end
end

class Appointment < ActiveRecord::Base
  	belongs_to :property
  	has_many :comments, as: :commentable
    has_attached_file :avatar
    do_not_validate_attachment_file_type :avatar
  	validates :date, :time, presence: true
  	validates :property_id, uniqueness: true
  	validates_with MustBeFuture
end


