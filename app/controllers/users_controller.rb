class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
      if @user.save
        UsersMailer.notify_new_user(User.last).deliver_now
        session[:user_id] = @user.id
        redirect_to root_path
      else
        render :new
      end
  end

  def show
    @user = User.find params[:id]
    @posts = @user.posts
    # .friendly
  end

  def edit
    #redirect_to root_path, alert: "Access denied." unless can? :edit, @user
    @user = current_user
  end

  def update
    @user = User.find params[:id]
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render "edit"
    end
  end


  private


  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                              :password, :password_confirmation, :image)
  end


end
