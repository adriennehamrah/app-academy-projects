class PostsController < ApplicationController
  before_action :redirect_unless_logged_in, except:[:show]
  before_action :redirect_unless_author, only:[:edit, :update]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create

    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to post_url(@post)
    else
      debugger
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def redirect_unless_author
    return if current_user.posts.find_by(id: params[:id])
    flash[:errors] = ['Not the post author']
    redirect_to posts_url
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :user_id, sub_ids: [])
  end
end
