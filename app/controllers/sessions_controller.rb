class SessionsController < ApplicationController
  def new
  end

  def create
     @user = User.find_by({"email" => params["email"]})
     if @user != nil # 1. when user exists
      if BCrypt::Password.new(@user["password"]) == params["password"] # 1-1. when password is correct
        cookies["zebra"] = "giraffe"
        session["user_id"] = @user["id"]

        flash["notice"] = "Welcome."
        redirect_to "/places"
      else
        flash["notice"] = "Incorrect password." # 1-2. when password is incorrect
        redirect_to "/login"
      end
    else
      flash["notice"] = "Email not found." # 2. when user doesn't exist
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end
  