class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    before_action :only_signed_in

    add_flash_types :success, :danger

    helper_method :current_user, :user_signed_in?

    private
    def only_signed_in
        if !user_signed_in?
            redirect_to new_user_path, danger: "Vous n'avez pas le droit d'accéder à cette page"
        end
    end

    # Retourne l'utilisateur actuellement connecté
    def current_user
        return nil if !session[:auth] || !session[:auth]['id']
        return @user if @user
        @user = User.find_by_id(session[:auth]['id'])
    end

    def user_signed_in?
        current_user.nil?
    end
end
