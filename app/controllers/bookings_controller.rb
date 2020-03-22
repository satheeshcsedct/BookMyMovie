class BookingsController < ApplicationController
  before_action :find_objects, only: %i[new create]
  before_action :login_required, only: %i[new]
  before_action :find_discount, only: %i[create validate_coupon_code]

  def index
    @bookings = current_user.bookings.joins(:show_timing).order('date desc, show_timings.start_time desc')
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params.merge!(user_id: current_user.id, amount: @show_timing.calculate_ticket_price(current_user, @discount)))
    @booking.discounts << Discount.flat5 if current_user.female?
    @booking.discounts << @discount if @discount
    if @booking.save
      redirect_to movies_path, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def validate_coupon_code
    @show_timing = ShowTiming.find(params[:show_timing_id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, notice: 'Booking was successfully deleted.'
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :release_id, :show_timing_id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def find_objects
    @release = Release.find(params[:release_id] || booking_params[:release_id])
    @show_timing = ShowTiming.find(params[:show_timing_id] || booking_params[:show_timing_id])
    @date = params[:date]
  end

  # Only allow a list of trusted parameters through.
  def movie_params
    params.require(:movie).permit(:name, :description)
  end

  def login_required
    return if current_user.present?

    redirect_to login_path
  end

  def find_discount
    coupon_code = params[:coupon_code]
    return if coupon_code.blank?

    @discount = Discount.find_by_coupon_code coupon_code
  end
end
