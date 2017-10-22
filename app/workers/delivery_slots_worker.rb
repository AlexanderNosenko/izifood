class DeliverySlotsWorker
  include Sidekiq::Worker
  
  def perform(*args)
    vendor = args[0]
    raise ArgumentError.new("No vendor passed") if vendor.blank?
    DeliverySlot.get_new_slots(vendor)
  end

end