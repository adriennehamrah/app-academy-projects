class AlbumsController < ApplicationController
  def show
    @album = album.find(params[:id])
    render :show
  end

  def new
    @bands = Band.all
    @band = Band.find(params[:band_id])
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    @album = album.find(params[:id])

    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = album.find(params[:id])
    @album.destroy
    redirect_to albums_url
  end

  private
  def album_params
    params.require(:album).permit(:title, :live, :year, :band_id)
  end
end
