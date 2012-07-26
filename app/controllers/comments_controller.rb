class CommentsController < ApplicationController
  helper :all
  before_filter :require_login
  def favorite_show
    user_id = current_user.id
    use_case_id = params[:use_case_id] or nil

    if use_case_id
      @fav = Favorite.where("user_id = ? AND use_case_id = ?", user_id, use_case_id)
    else
      @fav = nil
    end

    respond_to do |format|
      format.json { render json: @fav }
    end
  end

  def wow_show
    user_id = current_user.id
    use_case_id = params[:use_case_id] or nil

    if use_case_id
      @wow = Wow.where("user_id = ? AND use_case_id = ?", user_id, use_case_id)
    else
      @wow = nil
    end

    respond_to do |format|
      format.json { render json: @wow }
    end
  end

  def metoo_show
    user_id = current_user.id
    use_case_id = params[:use_case_id] or nil
    if use_case_id
      @metoo = Metoo.where("user_id = ? AND use_case_id = ?", user_id, use_case_id)
    else
      @metoo = nil
    end

    respond_to do |format|
      format.json { render json: @metoo }
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

  def favorite_delete
    @user_id = params[:comment][:user_id]
    @use_case_id = params[:comment][:use_case_id]

    @favorite = Favorite.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).first
    @favorite.destroy if !@favorite.blank?

    respond_to do |format|
      format.json { render json: Favorite.count }
    end
  end

  def wow_delete
    @user_id = params[:comment][:user_id]
    @use_case_id = params[:comment][:use_case_id]

    @wow = Wow.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).first
    @wow.destroy if @wow.blank?

    respond_to do |format|
      format.json { render json: Wow.count }
    end
  end

  def metoo_delete
    @user_id = params[:comment][:user_id]
    @use_case_id = params[:comment][:use_case_id]

    @metoo = Metoo.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).first
    @metoo.destroy if !@metoo.blank?

    respond_to do |format|
      format.json { render json: Metoo.count }
    end
  end
end
