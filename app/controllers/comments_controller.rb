class CommentsController < ApplicationController

  def index
    @comments = Comment.all.order(:created_at).reverse_order
  end

  def new
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @post = Post.find params[:post_id]
    @comment = Comment.new(comment_params)
    @comment.post = @post
    if @comment.save
      redirect_to post_path(@post), notice: "Comment created successfully!"
    else
      render "posts/show"
    end
  end


  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @comment
    else
      render :edit
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to post_path(comment.post)
  end




  private

  def comment_params
    params.require(:comment).permit(:body)
  end


end
