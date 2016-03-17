module ToursHelper
  def delete_expired_sessions
    TourSession.destroy_all(['start_date + duration < ?', Date.current])
  end
end
