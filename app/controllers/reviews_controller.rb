class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def create
    @review = current_user.reviews.create(review_params)
    redirect_to @review.room, notice: "Thank you for rating the room!"
  end

  def destroy
    review = Review.find(params[:id])
    room = review.room
    review.destroy
    redirect_to room
  end

  private

  def review_params
    params.require(:review).permit(:room_id, :star, :comment)
  end
end