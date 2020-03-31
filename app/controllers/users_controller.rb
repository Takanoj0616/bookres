class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_user, only: [:edit, :update]

    def edit
        @user = User.find(params[:id])
    end

    def create
    	@user= User.new(user_parms)
    	@user.user_id = current_user.id
    	@user.save
    	redirect_to user_path(@user.id)
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          flash[:notice] = "successfully"
          redirect_to user_path(@user.id)
        else
            flash[:notice] = "error"
            render 'edit'
        end
    end

    def index
        @book = Book.new
        @users = User.all
        @user = current_user
    end

    def show
    	 @book = Book.new
         @user= User.find(params[:id])
         @books = @user.books
    end

     private
    def user_params
        params.require(:user).permit(:introduction, :name, :profile_image)
    end

    def correct_user
    user = User.find(params[:id])
        if current_user != user
          redirect_to user_path(current_user.id)
        end
    end

end