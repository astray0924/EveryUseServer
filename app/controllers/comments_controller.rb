class CommentsController < ApplicationController
  helper :all
  def index
    # HTTP param
    @user_id = params[:user_id]
    @use_case_id = params[:use_case_id]

    # data
    if !@user_id.blank? and !@use_case_id.blank?
      @user_favorite = Favorite.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).length
      @user_fun = Fun.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).length
      @user_metoo = Metoo.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).length
    else
      @user_favorite = Favorite.all.count
      @user_fun = Fun.all.count
      @user_metoo = Metoo.all.count
    end

    # response
    @comment = Hash.new
    @comment[:favorites_count] = @user_favorite
    @comment[:funs_count] = @user_fun
    @comment[:metoos_count] = @user_metoo

    respond_to do |format|
      format.json { render json: @comment}
    end
  end
  
  def list
    @funs = Fun.all
    @metoos = Metoo.all
    
    @funs_grouped = Hash.new
    @funs.each do |fun|
      if not @funs_grouped.has_key?(fun.user.username)        
        @funs_grouped[fun.user.username] = Array.new
      end
        
      @funs_grouped[fun.user.username].push(fun.created_at)
    end
    
    @metoos_grouped = Hash.new
    @metoos.each do |metoo|
      if not @metoos_grouped.has_key?(metoo.user.username)
        @metoos_grouped[metoo.user.username] = Array.new
      end
      
      @metoos_grouped[metoo.user.username].push(metoo.created_at)
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @metoos_grouped}
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

  def favorite_delete
    @user_id = params[:comment][:user_id]
    @use_case_id = params[:comment][:use_case_id]

    @favorite = Favorite.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).first
    @favorite.destroy if !@favorite.blank?

    respond_to do |format|
      format.json { render json: Favorite.count }
    end
  end

  def fun_add
    @fun = Fun.new(params[:comment])

    respond_to do |format|
      if @fun.save
        format.json { render json: Fun.count, status: :created }
      else
        format.json { render json: @fun.errors, status: :unprocessable_entity }
      end
    end
  end

  def fun_delete
    @user_id = params[:comment][:user_id]
    @use_case_id = params[:comment][:use_case_id]

    @fun = Fun.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).first
    @fun.destroy if !@fun.blank?

    respond_to do |format|
      format.json { render json: Fun.count }
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
