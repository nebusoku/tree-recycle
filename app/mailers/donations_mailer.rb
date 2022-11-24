#FIXME Donation receipt image not working
class DonationsMailer < ApplicationMailer
  include ApplicationHelper
  after_action :stop_delivery_if_disabled

  def stop_delivery_if_disabled
    unless setting.is_emailing_enabled
      mail.perform_deliveries = false
    end
  end

  def receipt_email
    @donation = params[:donation]
    @reservation = @donation.reservation
    return if @donation.is_receipt_email_sent
    mail(to: @donation.email, subject: 'Thank you for your donation')
    @donation.update(is_receipt_email_sent: true) if setting.is_emailing_enabled
    @reservation.logs.create(message: 'Donation receipt email sent.') if @reservation
  end

end
