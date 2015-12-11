module ApplicationHelper
  def room_url(room, size = "thumb")
    if room.photos.present?
      room.photos.first.image.url(size)
    else
      image_path("sample-room.jpg")
    end
  end
end
