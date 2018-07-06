class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :comment_params, only: [:create, :update]

  def new
    @comment = Comment.new(comment_params)
  end

  def edit
    @user = @comment.user
    @post = @comment.post
  end

  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html {redirect_to post_path(@comment.post_id), notice: 'Comment was successfully created.'}
        format.js
      else
        render 'new'
      end
    end
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to @comment.post, notice: 'Comment was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
  	@post = @comment.post
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Comment was successfully destroyed.' }
      format.js
    end
  end

  private

  def find_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
