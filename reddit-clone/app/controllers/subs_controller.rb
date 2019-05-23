class SubsController < ApplicationController
    before_action :require_signed_in!
    before_action :is_moderator!, only: [:update, :edit]

    def new
        @sub = Sub.new
        render :new
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.moderator_id = current_user.id
        if @sub.save
            flash[:success] = "Sub succesfully created"
            redirect_to sub_url(@sub.id)
        else
            flash.now[:errors] = 
            @sub.errors.full_messages
            render :new
        end
    end

    def show
        @sub = Sub.find(params[:id])
        render :show
    end

    def index
        @subs = Sub.all
        render :index
    end

    def edit
        @sub = Sub.find(params[:id])
        render :edit
    end

    def update
        @sub = Sub.find(params[:id])
        if @sub.update_attributes(sub_params)
            flash[:success] = "Updated, way to go!"
            redirect_to sub_url(@sub.id)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit
        end
    end

    private
    def is_moderator!
        @sub = Sub.find(params[:id])
        if current_user.id != @sub.moderator_id
            flash.now[:errors] = "Not the moderator error!"
            redirect_to sub_url(@sub.id)
        end
    end
    
    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end