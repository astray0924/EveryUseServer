class CommentsController < ApplicationController
  def index
    @user_id = params[:user_id]
    @use_case_id = params[:use_case_id]

    @favorites = Favorite.all
    @funs = Fun.all
    @metoos = Metoo.all

    @comments = Hash.new
    @comments[:favorites] = @favorites
    @comments[:funs] = @funs
    @comments[:metoos] = @metoos

    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end
end
