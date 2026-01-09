class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
    
      if @user.save
        # 🔐 login automatico
        session[:user_id] = @user.id
    
        # 📧 email di benvenuto
        UserMailer.welcome_email(@user).deliver_later
    
        redirect_to root_path,
                    notice: "Benvenuto #{@user.name}! Controlla la tua email 😊"
      else
        render :new, status: :unprocessable_entity
      end
    end
    
    
    
    
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
  