class CommentsController < ApplicationController

  before_action :authenticate_user


  def create
    comment_params = params.require(:comment).permit(:body)
    @post = Post.find params[:post_id]
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post
    respond_to do |format|
      if @comment.save
        format.html {redirect_to post_path(@post)}
        format.js {render :create_success}
      else
        format.html {render "posts/show"}
        format.js {render js: "alert('failure');"}
      end
    end
  end


  def destroy
    @comment = Comment.find params[:id]
    redirect_to root_path, alert: "access denied!" unless can?(:destroy, @comment)
    @comment.destroy
      respond_to do |format|
        format.html {redirect_to post_path(@comment.post), notice: "Comment deleted"}
        format.js { render }
      end
  end


end
