module ApplicationHelper
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
    ids = [@_request.parameters[:filter], @_request.parameters[:category]].reject { |f| f.blank? }
    ids.include?(id.to_s) ? default_style : ""
  end

  def filter_icon_url(icon_name)
    "/assets/" + icon_name.to_s
  end
end
