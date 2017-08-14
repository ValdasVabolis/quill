class Users::Questions::CommentsController < ApplicationController

  def create
    @comment = Comment.new({ user: current_user }.merge(users_questions_answers_comment_params))
    @comment.save
  end


  private
    def users_questions_answers_comment_params
      params.require(:comment).permit(:answer_id, :body)
    end
end