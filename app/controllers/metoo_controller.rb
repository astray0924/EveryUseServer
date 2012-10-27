class MetooController < ApplicationController
  def create
    @metoo = Metoo.new(params[:comment])

    respond_to do |format|
      if @metoo.save
        @result = Hash.new
        @result[:id] = @metoo.id
        
        format.json { render json: @result, status: :created }
      else
        format.json { render json: @metoo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @metoo = Metoo.find(params[:id])
    @metoo.destroy unless @metoo.blank?

    respond_to do |format|
      format.json { render json: nil }
    end
  end
end
