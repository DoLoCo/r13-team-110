module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def title_html(html_data)
    content_for(:title_html) { html_data.html_safe }
  end
end
