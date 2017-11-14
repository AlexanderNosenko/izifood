require "administrate/base_dashboard"

class QuantityMatchDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    origin: Field::BelongsTo.with_options(class_name: "QuantityMatch"),
    children: Field::HasMany.with_options(class_name: "QuantityMatch"),
    id: Field::Number,
    key: Field::String,
    value: Field::String,
    quantifier: Field::String,
    origin_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :origin,
    :children,
    :id,
    :key,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :origin,
    :children,
    :id,
    :key,
    :value,
    :quantifier,
    :origin_id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :origin,
    :children,
    :key,
    :value,
    :quantifier,
    :origin_id,
  ].freeze

  # Overwrite this method to customize how quantity matches are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(quantity_match)
  #   "QuantityMatch ##{quantity_match.id}"
  # end
end
