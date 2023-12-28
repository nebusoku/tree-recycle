class IsMissingTreeEmailSentToReservation < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :is_missing_tree_email_sent, :boolean, default: false
  end
end
