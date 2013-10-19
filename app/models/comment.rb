class Comment < ActiveRecord::Base
  belongs_to :idea
  belongs_to :user

  validates :idea_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true
end
