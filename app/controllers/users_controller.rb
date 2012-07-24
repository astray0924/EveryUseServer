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

  def favorited
    @page, @limit = get_pagination_params(params)

    @user = User.find(params[:id])
    @favorites = @user.favorite.paginate(:page => @page, :per_page => @limit).order('id DESC')

    @use_cases = Array.new
    @favorites.each do |favorite|
      @use_cases.append(favorite.use_case)
    end

    if type = params[:type]
      @use_cases = case type
      when 'item' then @use_cases.sort! {|a, b| a.item.downcase <=> b.item.downcase }
          when 'purpose' then @use_cases.sort! {|a, b| a.purpose.downcase <=> b.purpose.downcase }
          when 'time' then @use_cases.sort! {|a, b| b.created_at <=> a.created_at }
          else @use_cases
      end
    end

    respond_to do |format|
      format.json { render json: @use_cases }
    end
  end

  def commented
    @page, @limit = get_pagination_params(params)

    user = User.find(params[:id])
    type = params[:type].to_s.strip
    use_case = Array.new

    if type == "fun"
      use_case = user.fun.order('id DESC').paginate(:page => @page, :per_page => @limit)
    elsif type.eql?("metoo")
      use_case = user.metoo.order('id DESC').paginate(:page => @page, :per_page => @limit)
    else
      use_case = Array.new
    end

    use_case = use_case.map{ |x| x.use_case }

    respond_to do |format|
      format.json { render json: use_case }
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
