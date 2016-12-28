class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)
        @user = User.new(user_params)
        if @user.valid?
            @user.save
            UserMailer.confirm(@user).deliver_now
            redirect_to :new, success: 'Votre compte a bien été créé, vous aller recevoir un email pour le confirmer'
            render 'new'
        else
            render 'new'
        end
    end

end
