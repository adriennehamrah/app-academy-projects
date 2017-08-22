class ArtworksController < ApplicationController
  def index
    @artwork = Artwork.shared_viewers.find(params[:user_id])
    render json: @artwork
  end

  def create
    @artwork = Artwork.new(artwork_params)

    if @artwork.save
      render json: @artwork, status: :created
    else
      render json: @artwork.error.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render json: Artwork.find(params[:id])
  end

  def update
    @artwork = Artwork.find(params[:id])

    if @artwork.update(artwork_params)
      render json: @artwork, status: :ok
    else
      render json: @artwork.error.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @artwork = Artwork.find(params[:id])
    @artwork.destroy
    render json: @artwork
  end

  private
  def artwork_params
    params.require(:artwork).permit(:title, :image_url, :artist_id)
  end
end
