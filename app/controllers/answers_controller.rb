class AnswersController < ApplicationController

  def create
    #binding.pry
    #@question = Question.find(params[:question_id])
    #@answer = @question.answers.new(answer_params)
    #@answer.save
    #Answer.create(answer_params)
    #binding.pry
    @answer = Answer.new(answer_params)
    @question = Question.find(params[:question_id])
    @answers = @question.answers.all
    if @answer.save
      #redirect_to question_path(params[:question_id])
      #binding.pry

      respond_to do |format|
        format.html { redirect_to question_path(params[:question_id]) }
        format.json { @error_response = "" }
      end

    else
      #if @answer.response.blank?
        #flash.now[:response] = 'フラッシュメッセージ'
        #flash[:response] = 'フラッシュメッセージ'
        #@error_test = "回答を入力してください。"
      #end
      #binding.pry
      #redirect_to controller: 'questions', action: 'show', id: params[:question_id]

      respond_to do |format|
        format.html { redirect_to controller: 'questions', action: 'show', id: params[:question_id] }
        format.json { @error_response = "回答を入力してください。" }
      end
      
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:response).merge(user_id: current_user.id, question_id: params[:question_id])
  end

end
