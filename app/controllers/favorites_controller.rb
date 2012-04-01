class FavoritesController < ApplicationController
  before_filter :require_login, :only => [:new, :create, :destroy] # for test
  def index
    render :nothing => true
  end

  def show
    @favorite = Favorite.find(params[:id])

    respond_to do |format|
      format.json { render json: @favorite }
    end
  end

  def new
    @favorite = Favorite.new

    respond_to do |format|
      format.json { render json: @favorite }
    end
  end

  def find
    @user_id = params[:user_id]
    @use_case_id = params[:use_case_id]

    @favorite = Favorite.where("user_id = ? AND use_case_id = ?", @user_id, @use_case_id).first;
    
    respond_to do |format|
      format.json { render json: @favorite }
    end
  end

  def create
    params[:favorite][:user_id] = current_user.id
    @favorite = Favorite.new(params[:favorite])

    respond_to do |format|
      if @favorite.save
        format.json { render json: @favorite, status: :created }
      else
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
