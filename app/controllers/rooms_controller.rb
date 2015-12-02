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
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to @room, notice: "Room created successfully"
    else
      render 'new'
    end
  end

  def edit
    render 'new'
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: "Your room has been changed"
    else
      render 'new'
    end
  end

  private

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
