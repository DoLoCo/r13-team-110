class ThemesController < AuthenticatedController
  before_action :load_theme, only: [:show]

  def show
    respond_with @theme, layout: 'theme'
  end

  def new
    respond_with @theme = Theme.new
  end

  def create
    @theme = Theme.new(permitted_params.theme)
    @theme.users << current_user
    flash[:notice] = 'Successfully created theme!' if @theme.save
    respond_with @theme
  end

private

  def load_theme
    @theme = Theme.find(params[:id])
  end

end