class FavoritesController < ApplicationController
  before_filter :require_login, :only => [:new, :create] # for test
  
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

  def edit

  end

  def create
    params[:favorite][:user_id] = current_user.id
    @favorite = Favorite.new(params[:favorite])

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to @favorite, notice: 'Favorite was successfully created.'}
        format.json { render json: @favorite, status: :created, location: @use_case }
      else
        format.html { render action: "new" }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end
end
