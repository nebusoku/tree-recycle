class DonationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_reservation, only: %i[ create new ]

  def new
  end

  def create
    if params[:check]
    else

      @session = Stripe::Checkout::Session.create({
        line_items: [{
            price: 'price_1Lxwp5AY1LGWbDshKyepVUDL',
            quantity: 1
        }],
        mode: 'payment',
        client_reference_id: @reservation.id,
        metadata: {reservation_id: params[:reservation_id]},
        customer_email: @reservation.email,
        success_url: reservation_success_url(@reservation),
        cancel_url: new_reservation_donation_url(@reservation)
      })

      redirect_to @session.url, allow_other_host: true

      # respond_to do |format|
      #   format.js
      # end
    end
  end

  def cash_or_check
  end

  def success
  end

  def cancel
  end

  private
    def donation_params
      params.require(:donation).permit(:amount)
    end
    def set_reservation
      @reservation = Reservation.find(params[:id] ||= params[:reservation_id])
    end
end