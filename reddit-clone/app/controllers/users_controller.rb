class UsersController < ApplicationController
    def new
        @user = User.new
        render :new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            sign_in(@user)
            flash[:success] = "New User created!"
            redirect_to subs_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
        render :show
    end
    
    def edit
        @user = User.find(params[:id])
        render :edit
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            redirect_to user_url(@user.id)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :edit
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end