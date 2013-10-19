class Api::CommentsController < Api::BaseController
  before_action :load_idea, only: [:index, :create]
  before_action :load_comment, only: [:destroy]

  def index
    respond_with @comments = @idea.comments
  end

  def create
    @comment = @idea.comments.create(permitted_params.comment)
    @comment.user = current_user
    respond_with @comment
  end

  def destroy
    @comment.destroy
    respond_with @comment
  end

private

  def load_idea
    @idea = Theme.find(params[:idea_id])
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end
end