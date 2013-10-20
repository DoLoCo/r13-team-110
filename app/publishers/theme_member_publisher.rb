class ThemeMemberPublisher < Struct.new(:theme, :theme_member)

  def publish_create!
    Pusher["theme-#{theme.id}"].trigger('member-create', ThemeMemberSerializer.new(theme_member).to_json)
  end

  def publish_destroy!
    Pusher["theme-#{theme.id}"].trigger('member-remove', ThemeMemberSerializer.new(theme_member).to_json)
  end

end