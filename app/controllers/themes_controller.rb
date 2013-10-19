class ThemesController < AuthenticatedController
  before_action :load_theme_for_create, only: :create # CanCan workaround
  load_and_authorize_resource

  def index
    respond_with @themes = @themes.ordered.paginate(page: params[:page], per_page: 25)
  end

  def show
    respond_with @theme, layout: 'theme'
  end

  def new
    respond_with @theme
  end

  def create
    @theme.users << current_user
    flash[:notice] = 'Successfully created theme!' if @theme.save
    respond_with @theme
  end

private

  def load_theme_for_create
    @theme = Theme.new(permitted_params.theme)
  end
  
end