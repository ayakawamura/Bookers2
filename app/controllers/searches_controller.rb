class SearchesController < ApplicationController
  def search
    @model = params[:model]
    @word = params[:word]
    if @model == "User"
      @users = User.looks(params[:search], params[:word])
    elsif @model == "Book"
      @books = Book.looks(params[:search], params[:word])
    elsif @model == "Tag"
      @books = Book.tag_looks(params[:search], params[:word])
    end
  end

  def tag_search
    @books = Book.find(params[:tag_id])
  end
end
