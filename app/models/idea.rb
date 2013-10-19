class Idea < ActiveRecord::Base
  belongs_to :theme
  belongs_to :theme_member
end
