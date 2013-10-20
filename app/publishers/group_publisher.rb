class GroupPublisher < Struct.new(:theme, :group)

  def publish_create!
    Pusher["theme-#{theme.id}}"].trigger('group-create', GroupSerializer.new(group).to_json)
  end

  def publish_update!
    Pusher["group-#{group.id}}"].trigger('update', GroupSerializer.new(group).to_json)
  end

  def publish_destroy!
    Pusher["theme-#{theme.id}}"].trigger('group-remove', GroupSerializer.new(group).to_json)
  end

end