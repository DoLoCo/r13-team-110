class Api::UsersController < Api::BaseController
  before_action :load_theme

  def index
    respond_with @users = @theme.users
  end

private

  def load_theme
    @theme = Theme.find(params[:theme_id])
  end
end