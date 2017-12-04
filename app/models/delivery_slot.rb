# == Schema Information
#
# Table name: delivery_slots
#
#  id           :integer          not null, primary key
#  content_html :text             not null
#  vendor       :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class DeliverySlot < ApplicationRecord
  EXPIRE_IN = 1
  $redis = Redis::Namespace.new("izifood", :redis => Redis.new)

  validates :content_html, 
            :vendor, presence: true

  scope :fresh_for, -> (vendor){
                        where(vendor: vendor.to_s)
                       .where('created_at > ?', EXPIRE_IN.hours.ago)
                       .order(created_at: :desc)
                       .limit(1)
                      }

  # def is_fresh
  #   created_at > EXPIRE_IN.hours.ago
  # end

  class << self
    # def for(vendor)
    #   slots = fresh_for(vendor).first

    #   if slots.nil?
    #     get_new_slots(vendor)
    #   else
    #     slots
    #   end
    # end

    def get_new_slots(vendor)
      @tesco_api = Tesco.new
      slots_html = @tesco_api.delivery_slots_html
      create!({
        content_html: slots_html,
        vendor: vendor
      })
    end

    def update_slots
      vendors = ['tesco']
      job_ids = {}
      vendors.map do |vendor|
        job_id = DeliverySlotsWorker.perform_async(vendor)
        if job_id
          $redis.set("last_slots_job", job_id) 
        else
          job_id = $redis.get("last_slots_job")
        end

        job_ids[vendor.to_sym] = job_id
      end
      job_ids
    end

    def clean_job_status_cache
      $redis.del("last_slots_job")
    end
  end
  
end
