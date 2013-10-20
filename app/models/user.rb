class User < ActiveRecord::Base
  GUEST_USER_EMAIL = 'guest@test.com'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :theme_members
  has_many :themes, through: :theme_members
  has_many :ideas
  has_many :comments

  validates :name, presence: true

  scope :by_email, lambda { |email| where("email LIKE ?", "#{email}%") }
end
