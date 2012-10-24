class MainController < ApplicationController
  def index
    @carousel_list = UseCase.order(:created_at).limit(5)
    @wow_list = UseCase.order(:wows_count).limit(4) 
    @metoo_list = UseCase.order(:metoos_count).limit(4) 
  end
  
  def about
    
  end
end
