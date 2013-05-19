module ApplicationHelper
  def title(page_title)
    provide(:title, page_title)
  end

  def full_title(page_title)
    base_title = "#{APP_CONFIG['name']}"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
