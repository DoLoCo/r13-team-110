class Idea < ActiveRecord::Base
  belongs_to :theme
  belongs_to :group
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :theme_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true
end
