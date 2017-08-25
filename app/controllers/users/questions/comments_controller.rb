class Users::Questions::CommentsController < ApplicationController
  before_action :set_users_questions_comment, only: [:show, :edit, :update, :destroy, :vote]
  def create
    @comment = Comment.new({ user: current_user }.merge(users_questions_answers_comment_params))
    if @comment.save
    	flash[:notice] = 'Comment saved succesfully'
    else
    	flash[:danger] = 'Something went wrong. Please try again.'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def vote
    type = params[:type]
    if current_user.send("voted_#{type}_on?", @comment)
      @comment.unvote_by current_user
    else
      @comment.vote_by voter: current_user, vote: type
    end
  end

  def destroy
    @comment.soft_delete!
  end

  private

  def set_users_questions_comment
    @comment = Comment.find(params[:id])
  end

  def users_questions_answers_comment_params
    params.require(:comment).permit(:answer_id, :body)
  end
end