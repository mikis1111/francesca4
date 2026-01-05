class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
    def new
    end
  
    def create
      user = User.find_by(email: params[:email])
  
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:success] = "Bentornato, #{user.name}!"
        redirect_to root_path
      else
        flash.now[:error] = "Email o password errati."
        render :new, status: :unprocessable_entity
      end
    end
  
    def destroy
      session[:user_id] = nil
      flash[:success] = "Hai effettuato il logout."
      redirect_to root_path
    end
  end
  