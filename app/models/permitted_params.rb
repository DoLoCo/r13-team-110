class PermittedParams < Struct.new(:params, :current_user)
  def theme
    params.require(:theme).permit(*theme_attributes)
  end

  def theme_attributes
    [:title, :description]
  end

  def theme_member
    params.require(:theme_member).permit(*theme_member_attributes)
  end

  def theme_member_attributes
    [:user_id]
  end

  def idea
    params.require(:idea).permit(*idea_attributes)
  end

  def idea_attributes
    [:content]
  end
end