class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  validates :content, :user_id, :commentable_type, presence: true
  validates :content, length: { in: 6..2000 }
end
