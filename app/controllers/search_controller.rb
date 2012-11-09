class SearchController < ApplicationController
  def index
    @q = params[:q]
    @result = Hash.new

    if not @q.nil?
      @search_by_item = UseCase.where("item LIKE ?", "%#{@q}%")
      @search_by_purpose = UseCase.where("purpose LIKE ?", "%#{@q}%")

      # build result object
      @result[:q] = @q
      @result[:item] = @search_by_item
      @result[:purpose] = @search_by_purpose
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @result }
    end
  end
end
