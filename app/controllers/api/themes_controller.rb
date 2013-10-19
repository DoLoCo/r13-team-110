class Api::ThemesController < Api::BaseController
  before_action :load_theme_for_create, only: :create # CanCan workaround
  load_and_authorize_resource :theme

  def show
    respond_with @theme
  end

  def create
    respond_with @theme
  end

  def update
    @theme.update(permitted_params.theme)
    respond_with @theme
  end

private

  def load_theme_for_create
    @theme = Theme.create(permitted_params.theme)
  end

end