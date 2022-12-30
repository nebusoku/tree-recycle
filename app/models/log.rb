class Log < ApplicationRecord
  belongs_to :reservation

  after_create_commit -> { broadcast_prepend_to "logs", partial: "admin/logs/log" }
end
