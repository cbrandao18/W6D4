class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        user = User.find_by_credentials(params[:username], params[:password])
        if user
            sign_in(user)
            redirect_to user_url(user.id)
        else
            flash.now[:errors] = "Invalid username/password combo"
            render :new
        end
    end

    def destroy
        sign_out
        redirect_to new_session_url
    end
end