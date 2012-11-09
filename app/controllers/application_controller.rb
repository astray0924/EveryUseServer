class ApplicationController < ActionController::Base
  require 'will_paginate/array'

  helper :all
  helper_method :current_user, :current_user_session, :get_pagination_params
#  filter_parameter_logging :password, :password_confirmation

  # set per_page globally
  WillPaginate.per_page = 10

  protected

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def get_pagination_params(params)
    @page = (params[:page] || 1)
    @page = Integer(@page)

    # filter the page value
    if @page <= 0
      @page = 1
    end

    @limit = (params[:limit] || 10)

    return @page, @limit
  end

  private

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to root_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_url # halts request cycle
    end
  end

  def logged_in?
    !!current_user
  end
end
