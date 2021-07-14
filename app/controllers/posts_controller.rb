class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    if user_signed_in?
      #@users = User.where.not(id: current_user.id)
      #@users = User.all
      #@user = User.find(params[:id])
    end
    @posts = Post.includes(:user).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)

    redirect_to root_path
  end

  def show
  end

  def edit
  end

  def update
    @post.update(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  # def search
  # end

  private

  def post_params
    params.require(:post).permit(:text, :image).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
