class DeliverySlotsWorker
  include Sidekiq::Worker
  
  sidekiq_options({
    unique: true,
    expiration: 3 * 60
  })

  def perform(*args)
    vendor = args[0]
    raise ArgumentError.new("No vendor passed") if vendor.blank?


    # s = Redis::Semaphore.new(:map_reduce_semaphore, connection: "localhost")

    # unless s.locked?
      # s.lock(90)
      DeliverySlot.get_new_slots(vendor)
      # s.unlock
    # end

  


    # result = RubyProf.profile do
    # end
    # printer = RubyProf::MultiPrinter.new(result)
    # printer.print(:path => "./public/profiler", :profile => "profile")
  end

end