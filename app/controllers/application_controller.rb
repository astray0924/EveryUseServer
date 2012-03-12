class ApplicationController < ActionController::Base
	# protect_from_forgery
	helper_method :current_user, :get_pagination_params
	
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
