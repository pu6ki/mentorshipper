# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    technologies = []
    params[:user][:technologies].each do |name|
      technologies.push(Technology.find_or_create_by!(name: name))
    end

    params[:user][:technologies] = technologies

    @user = User.find_by(email: params[:user][:email])
    if @user.nil?
      @user = User.create!(params[:user].permit!)
    end
    if params[:user_type] == 'mentor'
      @mentor = Mentor.create!(user: @user)
    elsif params[:user_type] == 'team'
      @mentor = Mentor.joins(:user).where(users: { email: params[:mentor_email] }).first
      @team = Team.create!(user: @user, name: params[:team_name], mentor: @mentor)
    end
    @user.send_reset_password_instructions

    render json: @user, include: { technologies: { only: :name } }
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :first_name, :last_name, technologies: []])
  end

  def after_update_path_for(resource)
    p sign_in_path
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
