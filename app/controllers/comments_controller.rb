class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_article

    # GET /articles/:article_id/comments
    def index
        @comments = @article.comments
    end

    # POST /articles/:article_id/comments
    def create
        @article.comments.create(comment_params.to_h.merge!({user_id: current_user.id}))
        redirect_to article_path(@article), notice: 'Comment was successfully created.'
    end

    private 
    
    def set_article
        @article = Article.find(params[:article_id])
    end

    def comment_params
        params.require(:comment).permit(:body)  
    end
end
