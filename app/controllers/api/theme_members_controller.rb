class Api::ThemeMembersController < Api::BaseController
  before_action :load_theme, only: [:index, :create]
  before_action :load_theme_member, only: [:destroy]

  def index
    respond_with @theme_members = @theme.theme_members
  end

  def create
    respond_with @theme_member = @theme.theme_members.create(permitted_params.theme_member)
  end

  def destroy
    @theme_member.destroy
    respond_with @theme_member
  end

private

  def load_theme
    @theme = Theme.find(params[:theme_id])
  end

  def load_theme_member
    @theme_member = ThemeMember.find(params[:id])
  end

end