class CommentsController < ApplicationController

  def index
    @comments = Comment.all.order(:created_at).reverse_order
  end

  def new
    @comment = Comment.new
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment
    else
      render "new"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end


end
