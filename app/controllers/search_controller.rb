class SearchController < ApplicationController
  def index
    @query = params[:query]
    @type = params[:type]
    
    if not @query.nil? and not @type.nil?
      @result = UseCase.where(@type + " = ?", @query);
    else
      @result = {}
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @result }
    end
  end
end
