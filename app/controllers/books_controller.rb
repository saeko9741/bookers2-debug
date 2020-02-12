class BooksController < ApplicationController
before_action :authenticate_user!, only: [:show, :index, :create, :edit, :update, :destroy]
before_action :set_book, only: [:show, :edit, :update]
before_action :barrier_user, only:[:edit, :update]

  def show
    @book_new = Book.new
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
    if @book.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@book.id), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
  end

  def update
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end
  def set_book
    @book = Book.find(params[:id])
    # idが見つからない場合
  end
  def barrier_user
    # if @book.user_id != current_user.id
    # bookのidに紐づくuser_idはparamsで取得できない。
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

end
