module ApplicationHelper
  def room_url(room)
    if room.photos.present?
      room.photos.first.image.url(:thumb)
    else
      image_path("sample-room.jpg")
    end
  end
end
