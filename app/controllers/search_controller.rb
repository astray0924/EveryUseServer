class SearchController < ApplicationController
  def index
    @query = params[:query]

    @result = Hash.new

    if not @query.nil?
      @search_by_item = UseCase.where("item LIKE ?", "%#{@query}%");
      @search_by_purpose = UseCase.where("purpose LIKE ?", "%#{@query}%");

      @grouped_item = Hash.new
      @grouped_purpose = Hash.new

      # group cases by item
      @search_by_item.each do |value|
        @key = value.item
        if @grouped_item[@key].nil?
          @grouped_item[@key] = Array.new
        end
        @grouped_item[@key].push(value);
      end

      # group cases by purpose
      @search_by_purpose.each do |value|
        @key = value.purpose
        if @grouped_purpose[@key].nil?
          @grouped_purpose[@key] = Array.new
        end
        @grouped_purpose[@key].push(value);
      end

      # build result object
      @result[:query] = @query
      @result[:item] = @grouped_item
      @result[:purpose] = @grouped_purpose
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @result }
    end
  end
end
