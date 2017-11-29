# Be sure to restart your server when you modify this file.

# ApplicationController.renderer.defaults.merge!(
#   http_host: 'example.org',
#   https: false
# )
class MyCustomLinkRenderer < WillPaginate::ActionView::LinkRenderer
  def container_attributes
    {class: "pagination"}
  end

  def page_number(page)
    shit1= "<li class='page-item #{ page == current_page ? 'active' : ''}'><span class='page-link'>"

    shit2 = "#{ page == current_page ? '<span class="sr-only">(current)</span>' : ''}</span></li>"
    
    if page == 1
      '<li class="page-item first">' + 
        previous_or_next_page(page, 'First', "page-link") +
      '</li>'
    elsif @collection.total_pages == page
      '<li class="page-item last">' + 
        previous_or_next_page(page, 'Last', "page-link") +
      '</li>'
    elsif page == current_page
      shit1 + tag(:span, page) + shit2
    else
      shit1 + link(page, page, rel: rel_value(page)) + shit2
    end
  end

  def gap
    # text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
    # %(<span class="mr2">#{text}</span>)
  end

  def previous_page
    shit1 = '<li class="page-item">'
    shit2= '</li>'
    num = @collection.current_page > 1 && @collection.current_page - 1
    shit1 + previous_or_next_page(num, '< Prev', "page-link") + shit2
  end

  def next_page
    shit1 = '<li class="page-item">'
    shit2= '</li>'
    num = @collection.current_page < total_pages && @collection.current_page + 1
    shit1 + previous_or_next_page(num, 'Next >', "page-link") + shit2
  end

  def previous_or_next_page(page, text, classname)
    if page
      link(text, page, :class => classname)
    else
      tag(:span, text, :class => classname)
    end
  end
end