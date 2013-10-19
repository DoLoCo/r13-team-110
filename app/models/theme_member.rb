class ThemeMember < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user

  has_many :ideas
  has_many :comments
end
