module Admin
  class RecipeIngredientsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    def index
      @resources = RecipeIngredient
        
      #   .page(params[:page])
      #   .per(15)

      # super
      
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(scoped_resource,
                                           dashboard_class,
                                           search_term).run
      resources = resources.includes(*resource_includes) if resource_includes.any?
      resources = order.apply(resources)
      resources = resources.order(match: :asc).page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
        resources: resources,
        search_term: search_term,
        page: page,
        show_search_bar: show_search_bar?
      }
    end

    def update
      # if resource_params[:match] == ''
        
      requested_resource.update(resource_params)
      redirect_to admin_recipe_ingredients_path, notice: translate_with_resource("update.success")
    end
    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   RecipeIngredient.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
