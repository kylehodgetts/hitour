# Version 1.0
# Tour Controller Helper Methods
module ToursHelper
  # Remove all sessions where the current date
  # is greater than the start date + the duration amount
  # in days
  # Essentially saying to remove all sessions
  # past their expiry date
  def delete_expired_sessions
    TourSession.destroy_all(['start_date + duration < ?', Date.current])
  end
end
