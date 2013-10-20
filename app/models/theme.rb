class Theme < ActiveRecord::Base
  has_many :theme_members
  has_many :users, through: :theme_members
  has_many :groups, dependent: :destroy
  has_many :ideas, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true

  scope :search, lambda { |term|
    where('title LIKE ?', "%#{term}%")
  }
  scope :ordered, lambda { order('updated_at DESC') }
end
