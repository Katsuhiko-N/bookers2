class ApplicationController < ActionController::Base
    
    # 未ログインユーザをはじく
    before_action :authenticate_user!, except:[:top]
    before_action :configre_permitted_parameters, if: :devise_controller?
    
    
    def after_sign_in_path_for(resource)
        books_path
    end
    
    def after_sign_out_path_for(resource)
        about_path
    end
    
    
    protected
    
    def configre_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    end
    
end
