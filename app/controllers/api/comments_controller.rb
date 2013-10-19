class Api::CommentsController < Api::BaseController
  load_and_authorize_resource :theme
  load_and_authorize_resource :idea

  before_action :load_comment_for_create, only: :create # CanCan workaround
  load_and_authorize_resource :comment, through: :idea

  def index
    respond_with @comments
  end

  def create
    @comment.save!
    respond_with @comment
  end

  def destroy
    @comment.destroy
    respond_with @comment
  end

private

  def load_comment_for_create
    @comment = @idea.comments.build(permitted_params.comment)
    @comment.user = current_user
  end

end