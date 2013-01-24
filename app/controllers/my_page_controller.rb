class MyPageController < ApplicationController
  before_filter :require_user
  
  def shared
    @title = "Shared"
    @page, @limit = get_pagination_params(params)

    if !current_user
      @use_cases = []
    else
      @use_cases = UseCase.includes(:wow, :metoo, :favorite).where('user_id = ?', current_user.id).paginate(:page => @page, :per_page => @limit)
    end

    respond_to do |format|
      format.html { render :template => 'my_page/use_case_list' }
      format.json { render json: @use_cases }
    end
  end

  def commented
  end

  def scrapped
  end

  def following
  end
end
