module ApplicationHelper
  def params_paginate(page_no)
    "/?#{request.query_parameters.merge(page: page_no).to_query}"
  end

  def previous_page(pages)
    page_no = current_page
    if pages > 1 && page_no > 1
      "/?#{request.query_parameters.merge(page: page_no.pred).to_query}"
    else
      '#'
    end
  end

  def next_page(pages)
    page_no = current_page
    if pages > 1 && page_no < pages
      "/?#{request.query_parameters.merge(page: page_no.next).to_query}"
    else
      '#'
    end
  end

  def current_page
    request.query_parameters[:page].to_i
  end
end
