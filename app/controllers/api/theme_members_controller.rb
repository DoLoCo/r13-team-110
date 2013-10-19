class Api::ThemeMembersController < Api::BaseController
  load_and_authorize_resource :theme

  before_action :load_theme_member_for_create, only: :create # CanCan workaround
  load_and_authorize_resource :theme_member, through: :theme

  def index
    respond_with @theme_members
  end

  def create
    respond_with @theme_member
  end

  def destroy
    @theme_member.destroy
    respond_with @theme_member
  end

private

  def load_theme_member_for_create
    @theme_member = @theme.theme_members.create(permitted_params.theme_member)
  end

end