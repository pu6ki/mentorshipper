class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_team_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :update, :delete]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new post_params

    if @post.save
      flash[:success] = 'You have successfully created a post.'
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = 'Post updated successfully.'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post successfully deleted.'
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find_by id: params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :content, :technologies)
  end

  def verify_team_user
    redirect_to posts_path unless current_user.team?
  end
end
