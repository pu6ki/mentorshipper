class QuestionsController < ApplicationController
  before_action :verify_team_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_question, only: [:show, :edit, :update, :delete]
  before_action :set_answer, only: [:show]
  before_action :verify_author, only: [:edit, :update, :destroy]
  before_action :set_answers, only: [:show]

  def index
    if params[:technology_name]
      @technology = Technology.find_by name: params[:technology_name]
      @questions = @technology.questions
    elsif params[:team_id]
      @team = Team.find_by id: params[:team_id]
      @questions = @team.questions
    else
      @questions = Question.all
    end

    puts @questions

    @questions = Question.sort_solved @questions
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

  def set_question
    @question = Question.find_by id: params[:id]
  end

  def set_answer
    @answer = Answer.new
  end

  def set_answers
    @answers = @question.answers
  end

  def question_params
    params.require(:question).permit(:title, :content, :technology_id)
  end

  def verify_team_user
    flash[:alert] = 'You should be a team in order to access this view.'
    redirect_to questions_path unless current_user.team?
  end

  def verify_author
    flash[:alert] = 'You should be the author of the question in order to modify it.'
    redirect_to questions_path unless @question.team == current_user.userable
  end
end
