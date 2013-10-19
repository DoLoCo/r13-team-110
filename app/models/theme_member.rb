class ThemeMember < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user
  
  validates :user_id, presence: true, uniqueness: { scope: :theme_id }
end
