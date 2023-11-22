class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to facility_post_path(@comment.post.facility, @comment.post)
    else
      @post = @comment.post
      @comments = @post.comments.includes(:user)
      redirect_to facility_post_path(@post.facility, @post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
