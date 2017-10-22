# module Admin
# end
class Admin::UtilsController < Admin::ApplicationController
  def update_matches
    IngredientMatchesWorker.perform_async()
    redirect_to admin_search_duplicates_path
  end

  def update_slots
    DeliverySlot.update_slots
    redirect_to admin_delivery_slots_path
  end
  
end
