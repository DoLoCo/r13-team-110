class Idea < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user

  has_many :comments

  validates :theme_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true
end
