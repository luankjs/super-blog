class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:update, :destroy]
  before_action :set_post
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /posts/1/comments
  def index
    @comments = @post.comments

    render json: @comments
  end

  # GET /posts/1/comments/1
  def show
    render json: @comment
  end

  # POST /posts/1/comments
  def create
    @comment = @post.comments.build(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1/comments/1
  def update
    # byebug
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1/comments/1
  def destroy
    @comment.destroy
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end
    
    def set_comment
      # byebug
      @comment = @post.comments.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:text, :author_name, :author_email, :post_id)
    end
end
