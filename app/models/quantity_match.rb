# == Schema Information
#
# Table name: quantity_matches
#
#  id         :integer          not null, primary key
#  key        :string
#  value      :string
#  quantifier :string
#  origin_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class QuantityMatch < ApplicationRecord
  belongs_to :origin, class_name: 'QuantityMatch', optional: true
  has_many :children, class_name: 'QuantityMatch', foreign_key: 'origin_id', dependent: :destroy

  SPACE = /[[:space:]]/
  JOIN_SYM = " + "
  @@I = -1
  
  def self.calculate(_quantity)
    # quantity.split(',').each { |part|
    #   quantity += 
    # }.inject(0, :+)
     
    new_q = ""

    adapt_quantity(_quantity).split(JOIN_SYM).map do |part|
      new_q += parse_weight(part).to_s
    end
    new_q
  end

  def self.parse_weight(part)
    part.split(SPACE).each_slice(2) do |q|
      weight = self.to_weight(q[1])
      if weight.is_a? Numeric
        return q[0].to_f * weight
      else
        return q[0] + " " + weight.to_s
      end
    end
  end
  
  def self.to_weight(_quantity)
    saved_match = QuantityMatch.find_by(key: _quantity)
    if saved_match
      if saved_match.origin
        saved_match.origin.value.to_f
      else
        saved_match.value.to_f
      end
    else
      _quantity
    end
    # when 'ml', 'g', 'szczypta'
    #   1 
    # when 'łyzeczka'
    #   5
    # when 'łyzka', 'łyzki', 'łyżki', 'łyżka'
    #   16
    # when 'szkl'
    #   245   
    # when 'szt', 'sztuki'
    #   1
    # when 'litry'
    #   1000
  end
  
  def self.adapt_quantity(_quantity)
    _quantity
      .gsub(/\d\/\d/) { |fraction| fraction.to_number }
      .gsub(/\d+-\d+/) { |fraction| fraction.to_number }
      .gsub(',','.')
      .gsub(' i ','+')
      .gsub(/[[:space:]]+/, ' ')
   
  end

end

class String
  def to_number
    fraction = self.split("/")

    if fraction.length > 1
      fraction.each_slice(2).map { |q|
        (fraction[0].to_f / fraction[1].to_f).round(2)
      }[0]
    elsif self.split('-').count > 1
      self.split('-')[1]
    else
      self.gsub(',','.')
    end
  end

end
