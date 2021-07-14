class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    #@nickname = current_user.nickname
    #@posts = current_user.posts
    @post = @user.nickname
    @posts = @user.posts.includes(:user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if current_user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end
  
private
def user_params
  params.require(:user).permit(:nickname,:email,:password,:password_confirmation,:gender,:age)
end

end
