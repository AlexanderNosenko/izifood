# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  amount     :decimal(5, 2)    not null
#  user_id    :integer          not null
#  _type      :integer          default("subscription"), not null
#  status     :integer          default("uncleared"), not null
#  info       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Payment < ApplicationRecord
  belongs_to :user
  validates_presence_of :amount, :_type, :info
  
  enum _type: [:subscription]
  enum status: [:uncleared, :success, :declined]
  CURRENT_MONTH = Time.now.strftime('%m.%Y')
 
  def self.for_current_month_by?(user)
    user.payments.where(status: [:uncleared, :success], _type: :subscription)
      .where("(info ->> 'valid_until')::timestamp >= to_timestamp('?')", Time.now.to_i)
      .count > 0
  end

  # def self.new_subcription_payment_for(user)
  #   user.payments.new({
  #     amount: 15, 
  #     _type: :subscription,
  #     status: :success,
  #     info: {"sub_date": CURRENT_MONTH}
  #   })
  # end
end
