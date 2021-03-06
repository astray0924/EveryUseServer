class RelationshipsController < ApplicationController
  def index
    @relationships = Relationship.all;
    
    respond_to do |format|
      format.json { render json: @relationships }
    end
  end
  
  def show
    follower_id = params[:relationship][:follower_id]
    followed_id = params[:relationship][:followed_id]
    
    @relationship = Relationship.where("follower_id = ? AND followed_id = ?", follower_id, followed_id).first
    
    respond_to do |format|
      format.json { render json: @relationship }
    end
  end
  
  def create
    @followed = User.find(params[:relationship][:followed_id])
    @follower = User.find(params[:relationship][:follower_id])
    @relationship = @follower.follow!(@followed)
    
    respond_to do |format|
      format.json { render json: @relationship }
    end
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    if not @relationship.blank? then @relationship.destroy end
    
    respond_to do |format|
      format.json {render json: 1}	# temporary
    end
  end
end
