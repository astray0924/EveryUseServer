class CommentsController < ApplicationController
  helper :all
  # before_filter :require_login, :only => [:favorite_add, :wow_add, :metoo_add]
  def show
    user_id = params[:comment][:user_id]
    use_case_id = params[:comment][:use_case_id]

    if user_id and use_case_id
      @fav = Favorite.where("user_id = ? AND use_case_id = ?", user_id, use_case_id).first
      @wow = Wow.where("user_id = ? AND use_case_id = ?", user_id, use_case_id).first
      @metoo = Metoo.where("user_id = ? AND use_case_id = ?", user_id, use_case_id).first
      
      @wow_count = UseCase.find(use_case_id).wows_count
      @metoo_count = UseCase.find(use_case_id).metoos_count

      @comments = Hash.new
      @comments[:favorite] = @fav
      @comments[:wow] = @wow
      @comments[:metoo] = @metoo
      @comments[:wow_count] = @wow_count
      @comments[:metoo_count] = @metoo_count
    else
      @comments = nil
    end


    respond_to do |format|
      format.json { render json: @comments }
    end
  end
end
