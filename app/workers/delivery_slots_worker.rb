class DeliverySlotsWorker
  include Sidekiq::Worker
  
  def perform(*args)
    vendor = args[0]
    raise ArgumentError.new("No vendor passed") if vendor.blank?

    # result = RubyProf.profile do
      DeliverySlot.get_new_slots(vendor)
    # end

    # printer = RubyProf::MultiPrinter.new(result)
    # printer.print(:path => "./public/profiler", :profile => "profile")

  end

end