require "administrate/base_dashboard"

class RecipeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    recipe_ingredients: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    images: Field::String,
    description: Field::Text,
    desc_images: Field::String,
    r_type: Field::String.with_options(searchable: false),
    prep_time: Field::String.with_options(searchable: false),
    prep_type: Field::String.with_options(searchable: false),
    cost: Field::String.with_options(searchable: false),
    calories: Field::String.with_options(searchable: false),
    portion_size: Field::String.with_options(searchable: false),
    main_ingredient: Field::String.with_options(searchable: false),
    cuisine: Field::String.with_options(searchable: false),
    veg: Field::Boolean,
    grill: Field::Boolean,
    status: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :recipe_ingredients,
    :id,
    :title,
    :images,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :recipe_ingredients,
    :id,
    :title,
    :images,
    :description,
    :desc_images,
    :r_type,
    :prep_time,
    :prep_type,
    :cost,
    :calories,
    :portion_size,
    :main_ingredient,
    :cuisine,
    :veg,
    :grill,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :recipe_ingredients,
    :title,
    :images,
    :description,
    :desc_images,
    :r_type,
    :prep_time,
    :prep_type,
    :cost,
    :calories,
    :portion_size,
    :main_ingredient,
    :cuisine,
    :veg,
    :grill,
    :status
  ].freeze

  # Overwrite this method to customize how recipes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(recipe)
  #   "Recipe ##{recipe.id}"
  # end
end
