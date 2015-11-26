class VotesController < ApplicationController
  before_action :authenticate_user

  def create
    post = Post.friendly.find params[:post_id]
    vote = current_user.votes.new vote_params
    vote.post = post
    if vote.save
      redirect_to post_path(post)
    else
      redirect_to post_path(post)
    end
  end

  def destroy
    post = Post.friendly.find params[:post_id]
    vote = current_user.votes.find params[:id]
    vote.destroy
    redirect_to post_path(post)
  end

  def update
    vote = current_user.votes.find params[:id]
    post = Post.friendly.find params[:post_id]
    if vote.update vote_params
      redirect_to post_path(post)
    else
      redirect_to post_path(post)
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end

end
