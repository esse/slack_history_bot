class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def slack
    if request.env["omniauth.auth"].info.team != "Avangarda"
      flash['error'] = 'Wolno logować się tylko z Avy!'
      redirect_to '/'
      return
    end
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end
end