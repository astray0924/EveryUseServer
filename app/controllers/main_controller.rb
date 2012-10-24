class MainController < ApplicationController
  def index
    @carousel_list = UseCase.includes(:user).order(:created_at).limit(5)
    @wow_list = UseCase.includes(:user).order(:wows_count).limit(4) 
    @metoo_list = UseCase.includes(:user).order(:metoos_count).limit(4) 
  end
  
  def about
    
  end
end
