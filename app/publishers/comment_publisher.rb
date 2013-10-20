class CommentPublisher < Struct.new(:theme, :idea, :comment)

  def publish_create!
    Pusher["theme-#{theme.id}-idea-#{idea.id}"].trigger('comment-create', CommentSerializer.new(comment).to_json)
  end

  def publish_destroy!
    Pusher["theme-#{theme.id}-idea-#{idea.id}"].trigger('comment-remove', CommentSerializer.new(comment).to_json)
  end

end