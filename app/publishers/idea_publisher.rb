class IdeaPublisher < Struct.new(:theme, :idea)

  def publish_create!
    Pusher["theme-#{theme.id}"].trigger('idea-create', IdeaSerializer.new(idea).to_json)
  end

  def publish_update!
    Pusher["theme-#{theme.id}-idea-#{idea.id}"].trigger('update', IdeaSerializer.new(idea).to_json)
  end

  def publish_destroy!
    Pusher["theme-#{theme.id}"].trigger('idea-remove', IdeaSerializer.new(idea).to_json)
  end

end