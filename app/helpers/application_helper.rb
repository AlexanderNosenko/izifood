module ApplicationHelper
  def include_page_css(controller_name)
  	if (Rails.application.assets || ::Sprockets::Railtie.build_environment(Rails.application)).find_asset("#{controller_name}.scss")
  		stylesheet_link_tag controller_name
  	end
  end 
end
