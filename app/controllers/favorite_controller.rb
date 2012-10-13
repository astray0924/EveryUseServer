class FavoriteController < ApplicationController
  def show
    @favorite = Favorite.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @favorite }
    end
  end
  
  def create
    @favorite = Favorite.new(params[:comment])

    respond_to do |format|
      if @favorite.save
        format.json { render json: Favorite.count, status: :created }
      else
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy unless @favorite.blank?

    respond_to do |format|
      format.json { render json: Favorite.count}
    end
  end
end
