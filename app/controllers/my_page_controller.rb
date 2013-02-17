class MyPageController < ApplicationController
  before_filter :require_user
  
  def shared
    @title = "Shared"
    @page, @limit = get_pagination_params(params)

    if !current_user
      @use_cases = []
    else
      @use_cases = current_user.use_cases.paginate(:page => @page, :per_page => @limit)
    end

    respond_to do |format|
      format.html { render :template => 'my_page/use_case_list' }
      format.json { render json: @use_cases }
    end
  end

  def commented
    @user = current_user
    @use_cases = Hash.new
    @use_cases[:wow] = @user.wow.order('id DESC').map{ |x| x.use_case }
    @use_cases[:metoo] = @user.metoo.order('id DESC').map{ |x| x.use_case }

    respond_to do |format|
      format.html
      format.json { render json: @use_cases }
    end
  end

  def scrapped
    @title = "Scrapped"
    @page, @limit = get_pagination_params(params)

    if !current_user
      @use_cases = []
    else
      @favorites = current_user.favorite.order('id DESC')
      @use_cases = @favorites.map{ |x| x.use_case }.paginate(:page => @page, :per_page => @limit)
    end

    respond_to do |format|
      format.html { render :template => 'my_page/use_case_list' }
      format.json { render json: @use_cases }
    end
  end

  def following
    @followings = current_user.followed_users

    respond_to do |format|
      format.html
      format.json { render json: @followings }
    end
  end
end
