class PagesController < ApplicationController
  def home
    @rooms = Room.all
  end

  def search
    @rooms = Room.active

    if params[:search].present? && params[:search].strip != ""
      @rooms = @rooms.near(params[:search], 1, order: "distance")
    end
    @search = @rooms.ransack(params[:q])
    @rooms = @search.result
    @arr_rooms = find_unavailable_rooms
  end

  private

  def find_unavailable_rooms
    arr_rooms = @rooms.to_a
    if (params[:start_date].present? && params[:end_date].present?)
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @rooms.each do |room|
        unavailable = room.where("(? < start_date AND end_date < ?) OR
                                (? < start_date AND ? < end_date) OR
                                (? < end_date AND end_date < ?)",
                                start_date, end_date,
                                start_date, end_date,
                                start_date, end_date).limit(1)
        if unavailable.length > 0
          arr_rooms.delete(room)
        end
      end
    end
    arr_rooms
  end

end
