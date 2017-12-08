class Authentication::RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    super
    if resource.persisted?
      resource.give_trial_promo!
      Menu.create_first_menu_for(resource)
    end
  end

  def update
    super
  end

end
