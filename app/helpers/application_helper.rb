module ApplicationHelper
 
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge :renderer => MyCustomLinkRenderer
    end
    super *[collection_or_options, options].compact
  end
  
  def include_page_css(controller_name)
    if (Rails.application.assets || ::Sprockets::Railtie.build_environment(Rails.application)).find_asset("#{controller_name}.scss")
      stylesheet_link_tag controller_name
    end
  end

  def include_page_js(controller_name)
    if (Rails.application.assets || ::Sprockets::Railtie.build_environment(Rails.application)).find_asset("#{controller_name}.js")
      javascript_include_tag controller_name
    end
  end

  def nav_bar_status(path)
    current_page?(path) ? "active" : ""
  end

  def flash_class_for(klass)
    case klass.to_sym
    when :success
      "success"
    when :notice
      "info"
    when :error
      "danger"
    when :warning
      "warning"
    else
      ""
    end
  end


  def clear_filters
    recipes_path({
      category: nil,
      filter: nil,
      q: nil
    })
  end

  def recipe_filters(type, id)
    # filters = @_request.parameters[:filters].to_a
    # categories = @_request.parameters[:categories].to_a

    # params = {
    #   categories: type != :filter ? categories|[id.to_s] : categories,
    #   filters: type == :filter ? filters|[id.to_s] : filters
    # }

    filter = @_request.parameters[:filter]
    category = @_request.parameters[:category]
    search = @_request.parameters[:q]

    params = {
      category: type == :category ? id : category,
      filter: type == :filter ? id : filter,
      q: search
    }#.reject { |a, d| as}
    # params = {}
    # params[:category] = id if type == :category
    # params[:filter] = id if type == :filter
    
    recipes_path(params)
  end

  def active_filter(id, default_style)
    ids = [@_request.parameters[:filter]].reject { |f| f.blank? }
    ids.include?(id.to_s) ? default_style : ""
  end

  def active_category(id, default_style)
    ids = [@_request.parameters[:category]].reject { |f| f.blank? }
    ids.include?(id.to_s) ? default_style : ""
  end
  def filter_icon_url(icon_name)
    "/assets/" + icon_name.to_s
  end

  def order_status_ribbon(order)
    status_class = ""
    status_text = ""

    case order.delivery
    when nil
      status_class = 'white'
      status_text = "New"
    else
      status_class = 'blue'
      status_text = "Pending"
    end

    if order.canceled?
      status_class = 'red'
      status_text = "Canceled"
    end

    html = <<-HTML
    <div class="corner-ribbon-wrapper">
      <div class="corner-ribbon order-status #{status_class}">
        #{status_text}
      </div>  
    </div>
    HTML

    html.html_safe
  end

  def short_description(menu)
    "( " + menu.recipes.map { |recipe|
      recipe.title[0..15] + "..."
    }.join(", ") + " )"
  end
end
