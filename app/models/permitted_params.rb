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

  def group
    params.require(:group).permit(*group_attributes)
  end

  def group_attributes
    [:title, :color]
  end

  def idea
    params.require(:idea).permit(*idea_attributes)
  end

  def idea_attributes
    [:content, :group_id]
  end

  def comment
    params.require(:comment).permit(*comment_attributes)
  end

  def comment_attributes
    [:content]
  end
end