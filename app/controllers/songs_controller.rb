class SongsController < ApplicationController
  def index
    if !params[:artist_id].blank?
      if params[:artist_id].to_i != 0
        if Artist.ids.include?(params[:artist_id].to_i)
          @songs = Song.artist_songs(params[:artist_id])
        else
          redirect_to artists_path, alert: "Artist not found"
        end
      else
        redirect_to artists_path
      end
    else
      @songs = Song.all
    end
  end

  def show
    if Song.ids.include?(params[:id].to_i)
      @song = Song.find(params[:id])
    else
      redirect_to artist_songs_path(params[:artist_id]), alert: "Song not found"
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end
