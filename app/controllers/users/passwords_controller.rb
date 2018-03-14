class PasswordsController < Devise::PasswordsController
  def edit
    render 'devise/passwords/set'
  end
end