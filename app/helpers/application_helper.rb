module ApplicationHelper
  # return the completed title for each page
  def full_title(page_title = '')
    base_title = "Pacifica"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
