class AnswersController < ApplicationController
  before_action :set_question
  before_action :verify_mentor_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_answer, only: [:show, :update, :edit, :destroy, :solving]
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
      flash[:notice] = 'You have successfully created an answer.'
      redirect_to @question
    else
      flash[:alert] = @answer.errors.full_messages
      render 'new'
    end
  end

  def edit
  end

  def update
    if @answer.update_attributes(answer_params)
      flash[:notice] = 'Answer updated successfully.'
      redirect_to @question
    else
      flash[:alert] = @answer.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @answer.destroy
    flash[:notice] = 'Answer successfully deleted.'
    redirect_to @question
  end

  def solving
    if @answer.update_attributes(solving: true)
      flash[:notice] = 'Question is successfully marked as solved.'
    else
      flash[:alert] = @answer.errors.full_messages
    end

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
    unless current_user.mentor?
      flash[:alert] = 'You should be a mentor in order to access this view.'
      redirect_to @question
    end
  end

  def verify_author
    unless @answer.mentor == current_user.userable
      flash[:alert] = 'You should be the author of the answer in order to modify it.'
      redirect_to @question
    end
  end
end
