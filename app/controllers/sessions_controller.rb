class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by({"email" => params["email"]})
    if @user != nil
      #2 if user exists, check if they know their password
      if BCrypt::Password.new(@user["password"]) == params["password"]
        #3 if they know their password, login successful
        cookies["user_id"] = @user["id"].to_s  
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome."
        redirect_to "/posts"
      else
        flash["notice"] = "Incorrect password."
        redirect_to "/login"
      end
    else
      flash["notice"] = "No user exists with this email."
      redirect_to "/login"
    end
end

def destroy
  #logout user
  session["user_id"] = nil
  cookies.delete("user_id")
  flash["notice"] = "See ya later."
  redirect_to "/login"
end

end


# In app/controllers/sessions_controller.rb, authenticate a user:
# find user by email.
# if no user is found: redirect to /login with a flash message
# if user exists: authenticate (i.e. check) their password
# if authentication succeeds: store the user's id in a secure cookie (i.e. session)
# if authentication succeeds: redirect to /posts with a flash message
# if authentication fails: redirect to /login with a flash message
# In app/controllers/sessions_controller.rb, logout a user in the destroy action
# In app/controllers/application_controller.rb, assign @current_user
# In app/views/layouts/application.html.erb, modify the navbar:
# conditionally hide the Login and Sign Up links if a user is logged in
# if user is logged in:
# hide Login and Sign Up buttons
# show first name of logged in user
# show a Logout button