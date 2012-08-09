class StatsController < ApplicationController
  def user_stats
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
      format.json { render json: @stats }
    end
  end
  
  def stats_advanced
    @users = User.all
    @users_stats = Hash.new
    
    @users.each do |user|
      # 필요한 데이터 수집
      list_givefun = user.wow           # GiveFun
      list_givemetoo = user.metoo       # GiveMetoo
      
      list_getwow = Array.new                 # GetFun
      list_getmetoo = Array.new               # GetMetoo
      user.use_cases.each do |use_case|
        list_getwow += use_case.wow
        list_getmetoo += use_case.metoo
      end
      list_uploadcase = user.use_cases  # UploadCase
      
      # 수집한 데이터를 AdvancedStatItem 클래스로 변환해서 하나의 array에 저장
      stats = Array.new
      
      # GiveFun 변환
      list_givefun.each do |give_fun|
        stat_item = AdvancedStatItem.new(user, give_fun.created_at, "GiveFun", give_fun.use_case)
        stats.append(stat_item)
      end
      
      # GiveMetoo 변환
      list_givemetoo.each do |give_metoo|
        stat_item = AdvancedStatItem.new(user, give_metoo.created_at, "GiveMetoo", give_metoo.use_case)
        stats.append(stat_item)
      end
      
      # GetFun 변환
      list_getwow.each do |get_fun|
        stat_item = AdvancedStatItem.new(user, get_fun.created_at, "GetFun", get_fun.use_case)
        stats.append(stat_item)
      end
      
      # GetMetoo 변환
      list_getmetoo.each do |get_metoo|
        stat_item = AdvancedStatItem.new(user, get_metoo.created_at, "GetMetoo", get_metoo.use_case)
        stats.append(stat_item)
      end
      
      # UploadCase 변환
      list_uploadcase.each do |upload_case|
        stat_item = AdvancedStatItem.new(user, upload_case.created_at, "UploadCase", upload_case)
        stats.append(stat_item)
      end
      
      # stat 아이템을 날짜로 정렬
      stats.sort! { |a, b| a.created_at <=> b.created_at }
      
      # users_stats에 stats 추가
      username = user.username
      @users_stats[username] = stats
    end

    respond_to do |format|
      format.html
      format.json { render json: @users_stats }
    end
  end

  def stats
    @users = User.all
    @stats = Array.new
    
    @users.each do |user|
      @use_cases = user.use_cases
      @use_cases_count = @use_cases.count        # 작성한 use_case 갯수
      
      @performed_metoo_count = user.metoo.count  # 사용자가 한 metoo 갯수
      @performed_fun_count = user.fun.count      # 사용자가 한 fun 갯수
      @received_metoo_count = 0                  # 사용자가 받은 metoo 갯수
      @received_fun_count = 0                    # 사용자가 받은 fun 갯수
      
      @use_cases.each do |use_case|
        @received_metoo_count += use_case.metoos_count
        @received_fun_count += use_case.funs_count
      end
      
      @stat = Hash.new
      @stat[:username] = user.username
      @stat[:use_case_count] = @use_cases_count
      @stat[:performed_metoo_count] = @performed_metoo_count
      @stat[:performed_fun_count] = @performed_fun_count
      @stat[:received_metoo_count] = @received_metoo_count
      @stat[:received_fun_count] = @received_fun_count
      
      # 한 유저에 대한 통계 오브젝트를 콜렉션에 추가
      @stats.append(@stat)
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @stats }
    end
  end

end

class AdvancedStatItem
  attr_accessor :user, :created_at, :activity, :target_case
  
  def initialize(user, created_at, activity, target_case)
    @user = user
    @created_at = created_at
    @activity = activity
    @target_case= target_case
  end
end