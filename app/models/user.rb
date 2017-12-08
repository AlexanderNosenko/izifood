# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar                 :string
#  name                   :string
#  provider               :string
#  uid                    :string
#  confirmation_token     :string
#  unconfirmed_email      :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unlock_token           :string
#  locked_at              :datetime
#  failed_attempts        :integer          default(0), not null
#

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]
  # :confirmable,

  mount_uploaders :avatar, AvatarUploader

  has_many :menus, dependent: :destroy
  has_many :delivery_addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :deliveries, through: :orders
  has_many :payments, dependent: :delete_all
  has_many :user_promotions
  has_many :promotions, through: :user_promotions, dependent: :delete_all


  alias_attribute :addresses, :delivery_addresses
  def current_menu
  	menus.find_by(main: true)#TODO change name column
  end

  def default_address
    delivery_addresses.find_or_initialize_by(default: true)
  end

  def active_member?
    Payment.for_current_month_by?(self)
  end

  def used_trial_promo?
    Promotion.of_action('trial').applied_for?(self)
  end

  def give_trial_promo!
    Promotion.of_action('trial').apply_to(self)
  end

  def give_influencer_promo!
    Promotion.of_action('influencer_coupon').apply_to(self)
  end
  
  def menus_with_recipes
  	menus.includes(:recipes).order(created_at: :asc)
  end

  def self.from_omniauth(auth)
    #todo properly handle auth
    
    where(provider: auth.provider, uid: auth.uid, email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.remote_avatar_urls = [auth.info.image + "?width=5555"]
      # user.skip_confirmation!
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
