class SearchController < ApplicationController
  def index
    @q = params[:q]
    @result = Hash.new

    if not @q.nil?
      @search_by_item = search_item(@q)
      @search_by_purpose = search_purpose(@q)

      # build result object
      @result[:q] = @q
      @result[:result_count] = @search_by_item.length + @search_by_purpose.length
      @result[:item] = @search_by_item
      @result[:purpose] = @search_by_purpose
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @result }
    end
  end

  def query_suggestion
    @q = params[:q]
    @attr = params[:attr]

    @result = if @q.blank? || @attr.blank? || !UseCase.column_names.include?(@attr)
      nil
    else
      UseCase.all(:conditions => ["#{@attr} LIKE ?", "#{@q}%"], :limit => 5, :order => @attr).map {|use_case| use_case[@attr] }
    end

    respond_to do |format|
      format.json { render json: @result }
    end
  end

  private

  def search_item(query)
    UseCase.where("item LIKE ?", "%#{query}%")
  end

  def search_purpose(query)
    UseCase.where("purpose LIKE ?", "%#{query}%")
  end
end
