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
        Pusher["theme-#{@theme.id}-idea-#{@idea.id}"].trigger('comment-create', CommentSerializer.new(@comment).to_json)
        format.json { render json: @comment }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity  }
      end
    end
  end

  def destroy
    @comment.destroy
    Pusher["theme-#{@theme.id}-idea-#{@idea.id}"].trigger('comment-remove', CommentSerializer.new(@comment).to_json)
    respond_with @comment
  end

private

  def load_comment_for_create
    @comment = @idea.comments.build(permitted_params.comment)
    @comment.user = current_user
  end

end