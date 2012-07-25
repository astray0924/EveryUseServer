class RelationshipsController < ApplicationController
  before_filter :require_login
  
  def index
    @relationships = Relationship.all;
    
    respond_to do |format|
      format.json { render json: @relationships }
    end
  end
  
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { render json: @user.followed_users }
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.json
    end
  end
end
