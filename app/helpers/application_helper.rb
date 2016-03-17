# Version 1.0
# Helper methods available throughout
# the application
module ApplicationHelper
  # Set and return the title
  # for the current page
  def title(page_title)
    content_for(:title) { page_title }
    page_title
  end
end
