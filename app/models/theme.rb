class Theme < ActiveRecord::Base
  has_many :theme_members
  has_many :users, through: :theme_members
  has_many :ideas, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
end
