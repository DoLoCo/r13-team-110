class IdeaSerializer < ActiveModel::Serializer
  attributes :id, :theme_id, :user_id, :content, :created_at
end
