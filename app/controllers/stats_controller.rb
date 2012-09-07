class StatsController < ApplicationController
  def user_activity_score
    @users = User.all
    @stats = Hash.new
    
    @users.each do |user|
      # 계산
      use_case_count = user.use_cases.length
      
      #
      comment_receive_count = 0
      wow_receive_count = 0
      metoo_receive_count = 0
      user.use_cases.each do |use_case|
        comment_receive_count += (use_case.wow.length + use_case.metoo.length)
        wow_receive_count += use_case.wow.length
        metoo_receive_count += use_case.metoo.length
      end
      
      #
      comment_commit_count = (user.wow.length + user.metoo.length)
      wow_commit_count = user.wow.length
      metoo_commit_count = user.metoo.length
      
      #
      score = (use_case_count * 10) + (comment_receive_count * 1) + (comment_commit_count * 1)
      
      # 해시에 입력
      username = user.username
      @stats[username] = Hash.new
      @stats[username]['use_case_count'] = use_case_count
      @stats[username]['comment_receive_count'] = comment_receive_count
      @stats[username]['wow_receive_count'] = wow_receive_count
      @stats[username]['metoo_receive_count'] = metoo_receive_count
      @stats[username]['comment_commit_count'] = comment_commit_count
      @stats[username]['wow_commit_count'] = wow_commit_count
      @stats[username]['metoo_commit_count'] = metoo_commit_count
      @stats[username]['score'] = score
      
      # sort by various fields
      # TODO
      
    end
  end
  
  def use_case_stats
    @user_group = params[:user_group]
    @user_group ||= 'all'
    
    @use_cases = UseCase.includes(:user)
    
    unless @user_group.eql?('all')
      @use_cases.select! {|use_case| use_case.user.user_group.eql?(@user_group)}
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @use_cases }
    end
  end
  
  def user_activity_log
    @users = User.all
    
    @user_id = params[:user_id]
    
    if @user_id
      @stats = Hash.new()
      
      @user = User.find(@user_id)
      @followings = @user.followed_users.all.sort_by { |item| item.id }   # followings
      # @followers = @user.followers.all.sort_by { |item| item.id }         # followers
      
      @wows = @user.wow.all.sort_by { |item| item.id }.map {|item| [item, "GiveWow"]}
      @metoos = @user.metoo.all.sort_by { |item| item.id }.map {|item| [item, "GiveMetoo"]}
      @scraps = @user.favorite.sort_by { |item| item.id }.map {|item| [item, "GiveScrap"]}
      @following_logs = Relationship.where("follower_id = ?", @user_id).map {|item| [item, "StartFollowing"]}
      @uploads = @user.use_cases.sort_by { |item| item.id }.map {|item| [item, "UploadCase"]}
      
      @activities = Array.new
      @activities.concat(@wows)
      @activities.concat(@metoos)
      @activities.concat(@scraps)
      @activities.concat(@following_logs)
      @activities.concat(@uploads)
      @activities.sort_by! {|activity| activity[0].created_at}    # comments
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @activities }
    end
  end
end