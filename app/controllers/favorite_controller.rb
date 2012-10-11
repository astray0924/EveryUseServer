class FavoriteController < ApplicationController
  def new
    @favorite = Favorite.find(params[:id])
    @favorite.destroy unless @favorite.blank?

    respond_to do |format|
      format.json { render json: Favorite.count}
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
