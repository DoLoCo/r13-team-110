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
        Pusher["theme-#{@theme.id}"].trigger('idea-create', IdeaSerializer.new(@idea).to_json)
        format.json { render json: @idea }
      else
        format.json { render json: @idea.errors, status: :unprocessable_entity  }
      end
    end
  end

  def update
    if @idea.update(permitted_params.idea)
      Pusher["theme-#{@theme.id}-idea-#{@idea.id}"].trigger('update', IdeaSerializer.new(@idea).to_json)
    end
    respond_with @idea
  end

  def destroy
    @idea.destroy
    Pusher["theme-#{@theme.id}"].trigger('idea-remove', IdeaSerializer.new(@idea).to_json)
    respond_with @idea
  end

private

  def load_idea_for_create
    @idea = @theme.ideas.build(permitted_params.idea)
    @idea.user = current_user
  end

end