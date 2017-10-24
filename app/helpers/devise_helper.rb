module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

  def error_for(field, _resource = nil)
    errors_html = ""
    resource = _resource if _resource

    resource.errors.messages[field.to_sym].map do |error|
      errors_html = errors_html + "<div class='alert alert-danger error'>" + error + "</div>"
    end

    html = <<-HTML
    <div class="error_explanation">
      #{errors_html}
    </div>
    HTML

    html.html_safe
  end

end