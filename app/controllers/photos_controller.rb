class PhotosController < ApplicationController
  def destroy
    photo = Photo.find(params[:id])
    room = photo.room
    photo.destroy
    @photos = room.photos
    respond_to :js
  end
end