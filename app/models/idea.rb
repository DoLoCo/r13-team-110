class Idea < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user

  has_many :comments
end
