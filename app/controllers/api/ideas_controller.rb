class Api::IdeasController < Api::BaseController
  before_action :load_theme, only: [:index, :create]
  before_action :load_idea, only: [:update, :destroy]

  def index
    respond_with @ideas = @theme.ideas
  end

  def create
    @idea = @theme.ideas.build(permitted_params.idea)
    @idea.user = current_user
    respond_with @idea
  end

  def update
    @idea.update(permitted_params.idea)
    respond_with @idea
  end

  def destroy
    @idea.destroy
    respond_with @idea
  end

private

  def load_theme
    @theme = Theme.find(params[:theme_id])
  end

  def load_idea
    @idea = Theme.find(params[:id])
  end
end