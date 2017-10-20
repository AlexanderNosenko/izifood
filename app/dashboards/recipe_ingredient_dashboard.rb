require "administrate/base_dashboard"

class RecipeIngredientDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    recipe: Field::BelongsTo,
    id: Field::Number,
    quantity: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    title: Field::String,
    match: Field::String.with_options(searchable: false),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :recipe,
    :id,
    :quantity,
    :created_at,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :recipe,
    :id,
    :quantity,
    :created_at,
    :updated_at,
    :title,
    :match,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :recipe,
    :quantity,
    :title,
    :match,
  ].freeze

  # Overwrite this method to customize how recipe ingredients are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(recipe_ingredient)
  #   "RecipeIngredient ##{recipe_ingredient.id}"
  # end
end
