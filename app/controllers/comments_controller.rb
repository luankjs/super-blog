class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:update, :destroy]
  before_action :set_article
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /articles/1/comments
  def index
    @comments = @article.comments

    render json: @comments
  end

  # GET /articles/1/comments/1
  def show
    render json: @comment
  end

  # POST /articles/1/comments
  def create
    @comment = @article.comments.build(comment_params)

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1/comments/1
  def update
    # byebug
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1/comments/1
  def destroy
    @comment.destroy
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
    end
    
    def set_comment
      # byebug
      @comment = @article.comments.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:text, :author_name, :author_email, :article_id)
    end
end
