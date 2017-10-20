module Admin
  class IngredientSearchesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    def index
      # super
      search_term = params[:search].to_s.strip

      if search_term 
        resources = IngredientSearch.where("search like ?", "%#{search_term}%")
      else
        resources = Administrate::Search.new(scoped_resource,
                                           dashboard_class).run
      end
      resources = resources.includes(*resource_includes) if resource_includes.any?
      resources = order.apply(resources)
      resources = resources.order(results: :asc).page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
        resources: resources,
        search_term: search_term,
        page: page,
        show_search_bar: show_search_bar?
      }

    end
    def update
      ingredient_search = IngredientSearch.find(params[:id])
      
      ingredient_search.results = params[:ingredient_search][:results].split(" ")
      ingredient_search.search = params[:ingredient_search][:search]

      if ingredient_search.save
        redirect_to admin_ingredient_search_path
      end

    end
    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   IngredientSearch.find_by!(search: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
