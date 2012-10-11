class FavoriteController < ApplicationController
  def new
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
