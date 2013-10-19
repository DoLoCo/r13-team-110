class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :theme_members
  has_many :themes, through: :theme_members
  has_many :ideas, through: :theme_members
  has_many :comments, through: :theme_members
end
