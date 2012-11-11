class UserSessionsController < ApplicationController
  # GET /user_sessions/new
  # GET /user_sessions/new.json
  def new
    @user_session = UserSession.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /user_sessions
  # POST /user_sessions.json
  def create
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      if @user_session.save
        format.html { redirect_to :back, :notice => "You have successfully logged in" }
        format.json { render json: @user_session, status: :created, location: @user_session }
      else
        format.html { redirect_to :back, :error => "Your email or password is incorrect" }
        format.json { render json: @user_session.errors, status: :unauthorized }
      end
    end
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.json
  def destroy
    @user_session = UserSession.find(params[:id])
    if @user_session then @user_session.destroy end

    respond_to do |format|
      format.html { redirect_to :back, :notice => "You have successfully logged out" }
      format.json { head :ok }
    end
  end
  
  # 2주 동안 로그인 유지
  def remember_me_for
    2.weeks
  end
end
