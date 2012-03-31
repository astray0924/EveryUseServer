class SearchController < ApplicationController
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def search
    @query = params[:query]
    
    # @item_result = UseCase.where();

    respond_to do |format|
      format.html
      format.json { render json: @use_cases }
    end
  end
end
