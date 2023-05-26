class Authentication::SessionsController < ApplicationController
	skip_before_action :no_login

  def new;end

  def create
    user = User.find_by_username(params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to root_path, notice: "Sessión iniciada!"
      elsif user.fiscal_gral?
        redirect_to institucion_votes_path, notice: "Sessión iniciada!"
      else user.fiscal?
        redirect_to mesa_votes_path, notice: "Sessión iniciada!"
      end
      
    else
      redirect_to login_path, alert: "Nombre de usuario o contraseña invalido"
    end
  end  

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "Logged out!"
  end
end