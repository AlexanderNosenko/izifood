require "administrate/base_dashboard"

class IngredientDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    order_items: Field::HasMany,
    translations: Field::HasMany.with_options(class_name: "IngredientTranslation"),
    id: Field::Number,
    title: Field::String,
    price_piece: Field::Number.with_options(decimals: 2),
    price_volume: Field::Number.with_options(decimals: 2),
    quantifier: Field::String,
    min_amount: Field::String,
    image: Field::String,
    tesco_id: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :order_items,
    :translations,
    :id,
    :title,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :order_items,
    :translations,
    :id,
    :title,
    :price_piece,
    :price_volume,
    :quantifier,
    :min_amount,
    :image,
    :tesco_id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :order_items,
    :translations,
    :title,
    :price_piece,
    :price_volume,
    :quantifier,
    :min_amount,
    :image,
    :tesco_id,
  ].freeze

  # Overwrite this method to customize how ingredients are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(ingredient)
  #   "Ingredient ##{ingredient.id}"
  # end
end
