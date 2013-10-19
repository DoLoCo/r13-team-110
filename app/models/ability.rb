class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      theme_ids = user.theme_members.pluck(:theme_id)

      # Theme
      # ---
      # any user can create a theme
      can :create, Theme

      # any user that is a member of the theme can read and update the theme
      can [:read, :update], Theme, id: theme_ids

      # Theme Member
      # ---
      # users can read, create, or destroy theme members if they belong to the theme of the theme member
      can [:read, :create, :destroy], ThemeMember, theme_id: theme_ids

      # Idea
      # ---
      # users can manage (CRUD) ideas if they belong to the theme of the idea
      can :manage, Idea, theme_id: theme_ids

      # Comment
      # ---
      # users can read and create comments to an idea that belongs to a theme that they are a member of
      can [:read, :create], Comment, idea: { theme_id: theme_ids }

      # users can destroy comments that they have created
      can :destroy, Comment, user_id: user.id
    end
  end
end
