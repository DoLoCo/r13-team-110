class ThemeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  has_many :theme_members
  has_many :groups
  has_many :ideas
end
