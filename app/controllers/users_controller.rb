class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
    
      if @user.save
        UserMailer.welcome(@user).deliver_later
        flash[:signup_success] = true
        redirect_to signup_path
      else
        flash.now[:alert] = @user.errors.full_messages.to_sentence
        render :new, status: :unprocessable_content
      end
      
    end
    
    
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
  