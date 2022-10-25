class Admin::ReservationsController < ApplicationController
  before_action :require_login
  before_action :set_reservation, except: %i[ new index search ]


  def index
    if params[:zone_id]
      @pagy, @reservations = pagy(Reservation.completed.where(zone_id: params[:zone_id]).order(created_at: :asc))
    elsif params[:uncompeted]
      @pagy, @reservations = pagy(Reservation.completed.where(zone_id: params[:zone_id]).order(created_at: :asc))
    else
      @pagy, @reservations = pagy(Reservation.completed.order(created_at: :asc))
    end
  end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to admin_reservation_url(@reservation), notice: "Reservation was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  #TODO add street to search
  def search
    @pagy, @reservations = pagy(Reservation.where("name ILIKE ? OR street ILIKE ?", "%" + Reservation.sanitize_sql_like(params[:search]) + "%", "%" + Reservation.sanitize_sql_like(params[:search]) + "%"))
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id] ||= params[:reservation_id])
    end

    def reservation_params
      params.require(:reservation).permit(:name, :email, :phone, :street, :city, :state, :zip, :country, :latitude, :longitude, :zone_id)
    end
end
