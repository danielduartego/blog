class LikesController < ApplicationController

  before_action :authenticate_user

  def create
    @like = Like.new
    @post = Post.friendly.find params[:post_id]
    @like.post = @post
    @like.user = current_user
    respond_to do |format|
      if current_user != @post.user
        @like.save
        # LikesMailer.notify_post_owner(like).deliver_now
        format.html {redirect_to post_path(post)}
        format.js {render :create_success}
      else
        format.html {redirect_to post_path(post), alert: "you can't like"}
        format.js {render js: "alert('can not like');"}
      end
    end
  end

  def destroy
    @post = Post.friendly.find params[:post_id]
    @like = current_user.likes.find params[:id]
    @like.destroy
      respond_to do |format|
        format.html {redirect_to post_path(post)}
        format.js { render }
      end
  end


end
