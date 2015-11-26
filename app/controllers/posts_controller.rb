class PostsController < ApplicationController

  before_action :authenticate_user, except: [:index, :show]

  before_action :find_post, only: [:show, :edit, :update, :destroy]

  before_action :authorize, only: [:edit, :update, :destroy]


  def index
    @posts = Post.all.order(:created_at).reverse_order
  end

  def show
    @comments = @post.comments
    @comment = Comment.new(post: @post)
  end


  def new
    @post = Post.new
  end


  def edit
    redirect_to root_path, alert: "Access denied." unless can? :edit, @post
  end


  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to(post_path(@post), notice: "Post Created!")
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render "edit"
    end
  end

  def destroy
  @post.destroy
  redirect_to posts_path
end


  private

  def post_params
    params.require(:post).permit([:title, :body, {tag_ids: []}], :image)
  end

  def authorize
    redirect_to root_path, alert: "Access denied!" unless can? :manage, @post
  end

  def find_post
    # finding the question by its id
    @post = Post.friendly.find params[:id]
  end

end
