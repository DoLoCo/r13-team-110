class Comment < ActiveRecord::Base
  belongs_to :idea
  belongs_to :theme_member
end
