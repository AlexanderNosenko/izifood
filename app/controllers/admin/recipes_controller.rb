module Admin
  class RecipesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    def index
      # super
      
      search_term = params[:search].to_s.strip
       if search_term 
        resources = Recipe.where("title like ?", "%#{search_term}%")
      else
        resources = Administrate::Search.new(scoped_resource,
                                           dashboard_class).run
      end
      resources = resources.includes(*resource_includes) if resource_includes.any?
      resources = order.apply(resources)
      resources = resources.order(status: :asc).paginate(:page => params[:page], :per_page => records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
        resources: resources,
        search_term: search_term,
        page: page,
        show_search_bar: show_search_bar?
      }
    end

    def update
      recipe = Recipe.find(params[:id])
      recipe.update_attribute(:status, params[:recipe][:status].to_i)
      redirect_to admin_recipes_path
    end
    
    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Recipe.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
