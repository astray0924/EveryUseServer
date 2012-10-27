class MainController < ApplicationController
  def index
    @carousel_list = UseCase.includes(:user).order(:created_at).limit(4)
    @wow_list = UseCase.order('wows_count DESC').includes(:user).limit(4) 
    @metoo_list = UseCase.order('metoos_count DESC').includes(:user).limit(4) 

    respond_to do |format|
      format.html
    end
  end

end
