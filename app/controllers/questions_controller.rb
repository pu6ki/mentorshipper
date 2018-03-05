class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_team_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_question, only: [:show, :edit, :update, :delete]
  before_action :set_answer, only: [:show]
  before_action :verify_author, only: [:edit, :update, :destroy]

  def index
    if params[:technology_name]
      @questions = Question.from_technology params[:technology_name]
    else
      @questions = Question.all
    end

    @questions = @questions.sort_by { |question| question.solved? ? 0 : 1 }
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.userable.questions.new question_params

    if @question.save
      flash[:notice] = 'You have successfully created a question.'
      redirect_to @question
    else
      flash[:alert] = @question.errors.full_messages
      render 'new'
    end
  end

  def edit
  end

  def update
    if @question.update_attributes(question_params)
      flash[:notice] = 'Question updated successfully.'
      redirect_to @question
    else
      flash[:alert] = @question.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    flash[:notice] = 'Question successfully deleted.'
    redirect_to questions_path
  end

  private

  def set_answer
    @answer = Answer.new
  end

  def set_question
    @question = Question.find_by id: params[:id]
  end

  def question_params
    params.require(:question).permit(:title, :content, :technology_id)
  end

  def verify_team_user
    redirect_to questions_path unless current_user.team?
  end

  def verify_author
    redirect_to questions_path unless @question.team == current_user.userable
  end
end
