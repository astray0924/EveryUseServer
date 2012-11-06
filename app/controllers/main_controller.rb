class MainController < ApplicationController
  def index
    @gallery_list = UseCase.includes(:user).order(:created_at).limit(15)
    @wow_list = UseCase.order('wows_count DESC').includes(:user).limit(5) 
    @metoo_list = UseCase.order('metoos_count DESC').includes(:user).limit(5) 

    respond_to do |format|
      format.html
    end
  end

end
