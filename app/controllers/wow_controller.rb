class WowController < ApplicationController
  def create
    @wow = Wow.new(params[:comment])

    respond_to do |format|
      if @wow.save
        @result = Hash.new
        @result[:id] = @wow.id
        
        format.json { render json: @result, status: :created }
      else
        format.json { render json: @wow.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @wow = Wow.find(params[:id])    
    @wow.destroy unless @wow.blank?

    respond_to do |format|
      format.json { render json: nil }
    end
  end
end
