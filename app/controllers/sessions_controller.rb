class SessionsController < ApplicationController
  def new
  end
  
  def create
    # TODO: authenticate user
    @user = User.find_by({"email" => params["email"]})
    if @user != nil
      redirect_to "/login"
      flash["notice"] = "No user found"
      #2 if user exists, check if they know their password
      if BCrypt::Password.new(@user["password"]) == params["password"]
        #3 if they know their password, login successful
        #add cookie fo ruser
   #add a cookie for this user
  cookies["monster"] = "cookie added"
  session["user_id"] = @user["id"]
  flash["notice"] = "Welcome."
  redirect_to "/posts"
  else

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