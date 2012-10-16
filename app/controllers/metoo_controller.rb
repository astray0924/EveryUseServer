class MetooController < ApplicationController
  def create
    @metoo = Metoo.new(params[:comment])

    respond_to do |format|
      if @metoo.save
        format.json { render json: Metoo.count, status: :created }
      else
        format.json { render json: @metoo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @metoo = Metoo.find(params[:id])
    @metoo.destroy unless @metoo.blank?

    respond_to do |format|
      format.json { render json: Metoo.count }
    end
  end
end
