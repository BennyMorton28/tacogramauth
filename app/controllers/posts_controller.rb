class PostsController < ApplicationController

    def index
      @posts = Post.all
    end
  
    def new
    end
  
    def create
      @post = Post.new
      @post["body"] = params["body"]
      @post["image"] = params["image"]
      @post["user_id"] = #need to update this!
      @post.save
      redirect_to "/posts"
    end
  
  end

  User.find_by({"id" => cookies["user_id"]}).user_id
