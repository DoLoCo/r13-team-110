class Group < ActiveRecord::Base
  belongs_to :theme

  validates :title, presence: true, uniqueness: { scope: :theme_id }
end
