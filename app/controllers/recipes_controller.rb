class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    # Recipe.update_tags_and_filters    

    recipes = Recipe.filter(params)
      .paginate(:page => params[:page], :per_page => 6)
    # current_user.give_trial_promo!
    # current_user.give_influencer_promo!

    categories = RecipeTag.categories
      .where("title <> 'Inne'")
      .order(created_at: :desc)
    
    categories = prepend_chosen(categories, params[:category])
    
    filters = RecipeTag.filters
    filters = prepend_chosen(filters, params[:filter])

    locals = {
      recipes: recipes,
      categories: categories,
      filters: filters
    }
    
    respond_to do |format|
      format.html { render locals: locals }
      format.js { render 'recipes/_list.js.erb', locals: locals }
    end
  
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    # [:=>[{:title=>"ziemniaki młode", :quantity=>"6-8 szt (duże)"}
    
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def prepend_chosen(tags, chosen)
    tags = tags.to_a
    tags.each_with_index do |tag, index|
      if tag.id.to_s == chosen.to_s
        temp = tags[index]
        tags[index] = tags[0]
        tags[0] = temp
      end
    end
    tags
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def recipe_params
    params.require(:recipe).permit(:title, :description)
  end

  def parse_recipes
    data = Parser.new.get_recipes(41, 99)
    data.each do |r|
      recipe = Recipe.create_from(r)
      RecipeIngredient.add_ingredients_from(r, recipe)
    end
    Recipe.convert_to_enum
  end
end
