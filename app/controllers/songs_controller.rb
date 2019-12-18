class SongsController < ApplicationController
  before_action :find_song, only: [:show, :edit, :delete, :edit]

  def index
    @songs = Song.all
  end

  def show
    
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    @song.artist = Artist.find_or_create_by(artist_params)

    if @song.save
      redirect_to song_path(@song)
    else
      render :new
    end
  end

  def edit
    # @song = Song.find(params[:id])
  end

  def update
    # @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    # @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title)
  end

  def artist_params
    params.require(:artist).permit(:name)
  end

  def find_song
    @song = Song.find(params[:id])
  end
end
