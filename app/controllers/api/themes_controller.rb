class Api::ThemesController < Api::BaseController
  before_action :load_theme, only: [:show, :update]

  def show
    respond_with @theme
  end

  def create
    respond_with @theme = Theme.create(permitted_params.theme)
  end

  def update
    @theme.update(permitted_params.theme)
    respond_with @theme
  end

private

  def load_theme
    @theme = Theme.find(params[:id])
  end


end