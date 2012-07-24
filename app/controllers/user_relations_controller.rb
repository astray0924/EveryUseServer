class UserRelationsController < ApplicationController
  def add
    @relation = UserRelation.new(params[:user_relation])

    respond_to do |format|
      if @relation.save
        render :nothing => true, status: :created
      else
        format.json { render json: @relation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @follower_id = params[:user_relation][:follower_id]
    @followee_id = params[:user_relation][:followee_id]

    @relation = UserRelation.where("follower_id = ? AND followee_id = ?", @follower_id, @followee_id).first
    @relation.destroy unless @relation.blank?

    respond_to do |format|
      render :nothing => true, status: :accepted
    end

  end

  def index
    @relations = UserRelation.all
    respond_to do |format|
      format.json { render json: @relations }
    end
  end
end
