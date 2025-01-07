class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:success] = "Instructions on resetting your password have been emailed to the address provided :)"
      redirect_to root_url
    else
      flash.now[:danger] = "Email not recogized, please try again"
      render "new", status: :unprocessable_entity
    end
  end
  #  In the case of an invalid submission we re-render the new page with a flash.now message.

  def edit
  end
end
