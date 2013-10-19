class CommentSerializer < ActiveModel::Serializer
  attributes :id, :idea_id, :user_id, :content, :created_at
end
