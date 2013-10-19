class Api::IdeasController < Api::BaseController
  load_and_authorize_resource :theme

  before_action :load_idea_for_create, only: :create # CanCan workaround
  load_and_authorize_resource :idea, through: :theme

  def index
    respond_with @ideas
  end

  def create
    respond_to do |format|
      if @idea.save
        format.json { render json: @idea }
      else
        format.json { render json: @idea.errors }
      end
    end
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

  def load_idea_for_create
    @idea = @theme.ideas.build(permitted_params.idea)
    @idea.user = current_user
  end

end