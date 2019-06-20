class AlbumsController < ApplicationController
  def index
  	@albums = Album.all.order(created_at: :desc)
  	@album = Album.new
		respond_to do |format|
		  format.html
		  format.js
	    end
  end

  def show
    @album = Album.find(params[:id])
  end

  def create
  	@albums = Album.all.order(created_at: :desc)
  	@album = Album.new(album_params)
  	@album.user_id = current_user.id
  	if @album.save
	  	respond_to do |format|
	      format.html
	      format.js
	    end
  	else
  		format.html {render :index}
  	end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to user_path(current_user.id)
  end

  private
  def album_params
  	params.require(:album).permit(:name, :user_id, {post_ids:[]})
  end
end
