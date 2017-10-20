require "administrate/base_dashboard"

class DeliveryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    order: Field::BelongsTo,
    id: Field::Number,
    deliver_on: Field::DateTime,
    cost_value: Field::String.with_options(searchable: false),
    cost_currency: Field::String,
    time_from: Field::String,
    time_to: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :order,
    :id,
    :deliver_on,
    :cost_value,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :order,
    :id,
    :deliver_on,
    :cost_value,
    :cost_currency,
    :time_from,
    :time_to,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :order,
    :deliver_on,
    :cost_value,
    :cost_currency,
    :time_from,
    :time_to,
  ].freeze

  # Overwrite this method to customize how deliveries are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(delivery)
  #   "Delivery ##{delivery.id}"
  # end
end
