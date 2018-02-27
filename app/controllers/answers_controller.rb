class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question
  before_action :verify_mentor_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_answer, only: [:show, :update, :destroy]
  before_action :verify_author, only: [:edit, :update, :destroy]

  def index
    @answers = @question.answers
  end

  def show
  end

  def new
    @answer = Answer.new
  end

  def create
    @answer = @question.answers.new answer_params
    @answer.mentor = current_user.userable

    if @answer.save
      flash[:success] = 'You have successfully created an answer.'
      redirect_to @question
    else
      puts @answer.errors.full_messages
      render 'new'
    end
  end

  def edit
  end

  def update
    if @answer.update_attributes(answer_params)
      flash[:success] = 'Answer updated successfully.'
      redirect_to @answer
    else
      render 'edit'
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = 'Answer successfully deleted.'
    redirect_to @question
  end

  private

  def set_question
    @question = Question.find_by id: params[:question_id]
  end

  def set_answer
    @answer = @question.answers.find_by id: params[:id]
  end

  def answer_params
    params.require(:answer).permit(:content)
  end

  def verify_mentor_user
    redirect_to @question unless current_user.mentor?
  end

  def verify_author
    redirect_to @question unless @answer.mentor == current_user.userable
  end
end
