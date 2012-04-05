class CommentsController < ApplicationController
  def index
    @user_id = params[:user_id]
    @use_case_id = params[:use_case_id]

    @favorites = Favorite.all
    @funs = Fun.all
    @metoos = Metoo.all

    @comments = Hash.new
    @comments[:favorites] = @favorites
    @comments[:favorites_count] = @favorites.length
    @comments[:funs] = @funs
    @comments[:funs_count] = @funs.length
    @comments[:metoos] = @metoos
    @comments[:metoos_count] = @metoos.length

    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end
end
