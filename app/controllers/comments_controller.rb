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
    else
      @fav = nil
      @wow = nil
      @metoo = nil
    end

    @comments = Hash.new
    @comments[:current_user_favorite] = @fav
    @comments[:current_user_wow] = @wow
    @comments[:current_user_metoo] = @metoo

    respond_to do |format|
      format.json { render json: @comments }
    end
  end

  def favorite_add
    @favorite = Favorite.new(params[:comment])

    respond_to do |format|
      if @favorite.save
        format.json { render json: Favorite.count, status: :created }
      else
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  def wow_add
    @wow = Wow.new(params[:comment])

    respond_to do |format|
      if @wow.save
        format.json { render json: Wow.count, status: :created }
      else
        format.json { render json: @wow.errors, status: :unprocessable_entity }
      end
    end
  end

  def metoo_add
    @metoo = Metoo.new(params[:comment])

    respond_to do |format|
      if @metoo.save
        format.json { render json: Metoo.count, status: :created }
      else
        format.json { render json: @metoo.errors, status: :unprocessable_entity }
      end
    end
  end

  def favorite_destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy unless @favorite.blank?

    respond_to do |format|
      format.json { render json: Favorite.count}
    end
  end

  def wow_destroy
    @wow = Wow.find(params[:id])
    @wow.destroy unless @wow.blank?

    respond_to do |format|
      format.json { render json: Wow.count }
    end
  end

  def metoo_destroy
    @metoo = Metoo.find(params[:id])
    @metoo.destroy unless @metoo.blank?

    respond_to do |format|
      format.json { render json: Metoo.count }
    end
  end
end
