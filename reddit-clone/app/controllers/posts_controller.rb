class PostsController < ApplicationController
    before_action :require_signed_in!, except: [:show]
    before_action :is_author!, only: [:edit, :update]
    
    def new
        @post = Post.new
        render :new
    end

    def create
        @post = Post.new(post_params)
        @post.author_id = current_user.id
        if @post.save
            flash[:success] = 'Post created!'
            redirect_to post_url(@post.id)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :new
        end
    end
    
    def show
        @post = Post.find(params[:id])
        render :show
    end

    def edit
        @post = Post.find(params[:id])
        render :edit
    end

    def update
        @post = Post.find(params[:id])
        if @post.update_attributes(post_params)
            redirect_to post_url(@post.id)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :edit
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to sub_url(@post.sub_id)
    end

    private
    def post_params
        params.require(:post).permit(:title, :url, :content, sub_ids: [])
    end

    def is_author!
        if current_user.id != @post.author_id
            flash[:errors] = "You cannot edit a post you didn't create."
            redirect_to post_url(@post.id)
        end
    end
end