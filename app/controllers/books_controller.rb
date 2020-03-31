class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

 def edit
  	@book = Book.new
  end

  def index
          @books = Book.all
          @book = Book.new
          @user = current_user
  end

  def show
        @book_new = Book.new
        @book = Book.find(params[:id])
        @user = @book.user
  end

  def edit
        @book = Book.find(params[:id])
  end

  def update
  	    @book = Book.find(params[:id])
        if @book.update(book_params)
          flash[:notice] = "successfully"
          redirect_to book_path(@book.id)
        else
          flash[:notice] = "error"
          render 'edit'
        end
  end

  def destroy
  	    book = Book.find(params[:id]) #データ(レコード)を1件取得
        book.destroy #データ（レコード）を削除
        redirect_to books_path #ダイレクト
  end

  def create
         @book = Book.new(book_params)
         @book.user_id = current_user.id
        if @book.save
           flash[:notice] = "successfully"
           redirect_to book_path(@book.id)
        else
          @books = Book.all
          @user = current_user
          render 'index'
        end


end

    private

  def book_params
        params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_user
    book = Book.find(params[:id])
    user = book.user_id
        if current_user.id != user
          redirect_to books_path
        end
    end
end
