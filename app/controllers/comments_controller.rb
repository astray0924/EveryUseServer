class CommentsController < ApplicationController
  helper :all
  before_filter :require_login, :only => [:new, :favorite_add, :fun_add, :metoo_add]
  def index
    @user_id = params[:user_id]
    @use_case_id = params[:use_case_id]

    @favorites = Favorite.all
    @funs = Fun.all
    @metoos = Metoo.all

    @comments = make_comments_object(@favorites, @funs, @metoos)

    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  def favorite_add
    @user_id = current_user.id
    @use_case_id = params[:use_case_id]
  end

  def favorite_delete
    @user_id = current_user.id
    @use_case_id = params[:use_case_id]
  end

  def fun_add
    @user_id = current_user.id
    @use_case_id = params[:use_case_id]
  end

  def fun_delete
    @user_id = current_user.id
    @use_case_id = params[:use_case_id]
  end

  def metoo_add
    @user_id = current_user.id
    @use_case_id = params[:use_case_id]
  end

  def metoo_delete
    @user_id = current_user.id
    @use_case_id = params[:use_case_id]
  end

  private

  def make_comments_object(favorites, funs, metoos)
    @comments = Hash.new
    @comments[:favorites] = favorites
    @comments[:favorites_count] = favorites.length
    @comments[:funs] = funs
    @comments[:funs_count] = funs.length
    @comments[:metoos] = metoos
    @comments[:metoos_count] = metoos.length

    return @comments
  end
end
