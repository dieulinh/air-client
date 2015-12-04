class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def preload
    room = Room.find(params[:room_id])
    today = Time.zone.today
    @reservations = room.reservations.where('start_date > ? OR end_date > ?', today, today)
    render json: @reservations
  end

  def create
    @reservation = current_user.reservations.create(reservation_params)
    redirect_to @reservation.room, notice: "Your booking has been made. Thank you for using our service"
  end

  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    @conflict = is_conflict?(start_date, end_date)
    render json: { conflict: @conflict }
  end

  private

  def is_conflict?(start_date, end_date)
    room = Room.find(params[:room_id])
    reservations = room.reservations.where('? < start_date AND end_date < ?', start_date, end_date)
    return (reservations.size > 0 ? true : false)
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :room_id, :price, :total)
  end
end