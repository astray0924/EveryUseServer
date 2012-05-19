class UsersController < ApplicationController
	helper :all
	# GET /users
	# GET /users.json
	def index
		@page, @limit = get_pagination_params(params)
		@users = User.paginate(:page => @page, :per_page => @limit).order('id DESC')

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @users }
		end
	end
	
	def stats
	  @users = User.all
	  @stats = Array.new
	  
	  @users.each do |user|
	    @use_cases = user.use_cases
	    @use_cases_count = @use_cases.count    # 작성한 use_case 갯수
	    
	    @performed_metoo_count = user.metoos.count # 사용자가 한 metoo 갯수
	    @performed_fun_count = user.funs.count     # 사용자가 한 fun 갯수
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

	def favorited
		@page, @limit = get_pagination_params(params)

		@user = User.find(params[:id])
		@favorites = @user.favorite.paginate(:page => @page, :per_page => @limit).order('id DESC')

		@use_cases = Array.new
		@favorites.each do |favorite|
			@use_cases.append(favorite.use_case)
		end

		respond_to do |format|
			format.json { render json: @use_cases }
		end
	end

	def commented
		@page, @limit = get_pagination_params(params)

		@user = User.find(params[:id])
		@funs = @user.fun.order('id DESC')
		@metoos = @user.metoo.order('id DESC')
		
		@use_cases = Hash.new
		
	  @use_cases[:fun] = Array.new
		@funs.each do |fun| 
		  @use_case = fun.use_case
		  @use_cases[:fun].append(@use_case)
		end

	  @use_cases[:metoo] = Array.new
	  @metoos.each do |metoo| 
	    @use_case = metoo.use_case
	    @use_cases[:metoo].append(@use_case)
	  end

		respond_to do |format|
			format.json { render json: @use_cases }
		end
	end

	# GET /users/1
	# GET /users/1.json
	def show
		@user = User.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @user }
		end
	end

	# GET /users/new
	# GET /users/new.json
	def new
		@user = User.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @user }
		end
	end

	# GET /users/1/edit
	def edit
		@user = User.find(params[:id])
	end

	# POST /users
	# POST /users.json
	def create
		@user = User.new(params[:user])

		respond_to do |format|
			if @user.save
				format.html { redirect_to @user, notice: 'User was successfully created.' }
				format.json { render json: @user, status: :created, location: @user }
			else
				format.html { render action: "new" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /users/1
	# PUT /users/1.json
	def update
		@user = User.find(params[:id])

		respond_to do |format|
			if @user.update_attributes(params[:user])
				format.html { redirect_to @user, notice: 'User was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /users/1
	# DELETE /users/1.json
	def destroy
		@user = User.find(params[:id])
		@user.destroy

		respond_to do |format|
			format.html { redirect_to users_url }
			format.json { head :no_content }
		end
	end
end
