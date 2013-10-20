class Api::CommentsController < Api::BaseController
  load_and_authorize_resource :theme
  load_and_authorize_resource :idea

  before_action :load_comment_for_create, only: :create # CanCan workaround
  load_and_authorize_resource :comment, through: :idea

  def index
    respond_with @comments
  end

  def create
    respond_to do |format|
      if @comment.save
        CommentPublisher.new(@theme, @idea, @comment).publish_create!
        format.json { render json: @comment }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity  }
      end
    end
  end

  def destroy
    @comment.destroy
    CommentPublisher.new(@theme, @idea, @comment).publish_destroy!
    respond_with @comment
  end

private

  def load_comment_for_create
    @comment = @idea.comments.build(permitted_params.comment)
    @comment.user = current_user
  end

end