class ReservationsController < ApplicationController
  before_action :authenticate_user!, except: :notify

  def index
    @reservations = Reservation.where(room_id: current_user.rooms)
  end

  def preload
    room = Room.find(params[:room_id])
    today = Time.zone.today
    @reservations = room.reservations.where('start_date > ? OR end_date > ?', today, today)
    render json: @reservations
  end

  protect_from_forgery except: [:your_trips]

  def your_trips
    @reservations = current_user.reservations
  end

  def create
    @reservation = current_user.reservations.create(reservation_params)
    if @reservation
      payment_info = {
        business: "ngdieulinh-facilitator@hotmail.com",
        cmd: "_xclick",
        upload: 1,
        notify_url: ENV["BUSINESS_HOST_NAME"]+"/notify",
        amount: @reservation.total,
        item_name: @reservation.room.listing_name,
        item_number: @reservation.id,
        quantity: "1",
        return: ENV["BUSINESS_HOST_NAME"] + "/your_trips"
      }
      redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?" + payment_info.to_query
    else
      redirect_to @reservation.room, notice: "Oops, Something went wrong"
    end
  end

  protect_from_forgery except: [:notify]

  def notify
    params.permit!
    status = params[:payment_status]
    reservation = Reservation.find(params[:item_number])
    if status = "Completed"
      reservations.update_attributes status: true
    else
      reservation.destroy
    end
    render nothing: true
  end

  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    @conflict = conflict?(start_date, end_date)
    render json: {conflict: @conflict}
  end

  private

  def conflict?(start_date, end_date)
    room = Room.find(params[:room_id])
    reservations = room.reservations.in_between_range(start_date, end_date)
    (reservations.size > 0 ? true : false)
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :room_id, :price, :total)
  end
end