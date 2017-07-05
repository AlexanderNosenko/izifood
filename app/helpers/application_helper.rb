module ApplicationHelper
  def include_page_css(controller_name)
  	stylesheet_link_tag controller_name if Izifood::Application.assets.find_asset("#{controller_name}.scss")
  end 
end
