class CommentsController < ApplicationController
    before_action :require_signed_in!
    
    def new
        @comment = Comment.new
        render :new
    end

    def create
        @comment = Comment.new(comment_params)
        @comment.author_id = current_user.id
        if @comment.save
            flash[:success] = "Comment created"
            redirect_to post_url(@comment.post_id)
        else
            flash.now[:errors] = @comment.errors.full_messages
            render :new
        end
    end

    def show
        @parent_comment = Comment.find(params[:id])
        @child_comment = @parent_comment.child_comments.new
        render :show
    end

    private
    def comment_params
        params.require(:comment).permit(:content, :post_id)
    end
end