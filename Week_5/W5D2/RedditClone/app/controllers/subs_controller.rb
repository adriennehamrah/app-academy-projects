class SubsController < ApplicationController
  before_action :redirect_unless_logged_in, except:[:index, :show]
  before_action :redirect_unless_moderator, only:[:edit, :update]

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = ['Update error']
      render :edit
    end
  end

  private

  def redirect_unless_moderator
    return if current_user.moderated_subs.find_by(id: params[:id])
    flash[:errors] = ['Not the moderator']
    redirect_to subs_url
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
