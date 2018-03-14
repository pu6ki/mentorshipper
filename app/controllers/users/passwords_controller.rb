class PasswordsController < Devise::PasswordsController
  def edit
    render '/set'
  end
end