class Authentication::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      flash[:info] = "Welcome back!"
      # set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    elsif @user.save
      resource.give_trial_promo!
      Menu.create_first_menu_for(resource)

      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      flash[:info] = "Welcome on board!"
      # set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    elsif @user.errors.details[:email].any?{|s| s[:error] == :taken}
      flash[:info] = "Account with email <strong>#{@user.email}</strong> exists"
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    else
      flash[:error] = "Error occured"
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end