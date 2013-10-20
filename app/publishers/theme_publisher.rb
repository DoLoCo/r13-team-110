class ThemePublisher < Struct.new(:theme)

  def publish_update!
    Pusher["theme-#{theme.id}"].trigger('update', ThemeSerializer.new(theme).to_json)
  end

end