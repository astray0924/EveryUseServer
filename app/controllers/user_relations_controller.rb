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

  def delete
    @follower_id = params[:user_relation][:follower_id]
    @relation = UserRelation.where("follower_id = ?", @follower_id).first
    @relation.destroy unless @relation.blank?

    respond_to do |format|
      render :nothing => true, status: :accepted
    end

  end
end
