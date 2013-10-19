class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      theme_ids = user.theme_members.pluck(:theme_id)

      can :create, Theme
      can [:read, :update], Theme, id: theme_ids
    end
  end
end
