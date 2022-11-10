class PostController < ApplicationController
    before_action :authenticate_user!
    def index
        @post = Post.all
    end

    def show
    end

    def new
        @post = Post.new
    end

    def create
        @post = current_user.post.build(post_params)
        if @post.save
            redirect_to root_path
        else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @post.errors, status: :unprocessable_entity }
        end
    end

    def post_params
        params.require(:post).permit(:title, :content, :user_id)
    end
end
