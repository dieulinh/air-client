class RoomsController < ApplicationController
  before_action :set_room, only: [:edit, :show, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = current_user.rooms.build
  end

  def show
    @photos = @room.photos
    @near_bys = @room.nearbys(10)
    @has_review = @room.reviews.find_by(user: current_user, room: @room).present? if current_user
    @booked = Reservation.room_booked_by_user?(@room, current_user) if current_user
    @reviews = @room.reviews
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      if params[:images]
        save_room_photos
      end
      redirect_to @room, notice: "Room created successfully"
    else
      render 'new'
    end
  end

  def edit
    @photos = @room.photos
    if current_user.id == @room.user.id
      render 'new'
    else
      redirect_to root_path, notice: "You don't have permission to edit this room"
    end
  end

  def update
    if @room.update(room_params)
      if params[:images]
        save_room_photos
      end
      redirect_to @room, notice: "Your room has been changed"
    else
      render 'new'
    end
  end

  private

    def save_room_photos
      params[:images].each do |image|
        @room.photos.create(image: image)
      end
    end

    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:home_type, :room_type, :accommodate,
                                    :listing_name, :bed_room, :bath_room, :price,
                                    :summary, :address, :active,
                                    :is_tv, :is_kitchen, :is_air, :is_internet, :is_heating
                                  )
    end

end
