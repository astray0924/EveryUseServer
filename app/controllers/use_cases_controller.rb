class UseCasesController < ApplicationController
  helper :all
  before_filter :require_login, :only => [:new, :edit, :create, :update]
  # GET /use_cases
  # GET /use_cases.json
  def index
    @page, @limit = get_pagination_params(params)
    @use_cases = UseCase.paginate(:page => @page, :per_page => @limit).order('id DESC')

    if params[:user_id]
      @use_cases = UseCase.where("user_id = ?", params[:user_id]).paginate(:page => @page, :per_page => @limit).order('id DESC')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @use_cases }
    end
  end

  def top
    @page, @limit = get_pagination_params(params)
    @type = (params[:type] || 'fun')
    @use_cases = nil

    if @type == 'fun'
      @use_cases = UseCase.order('funs_count DESC').where("funs_count > ?", 0).paginate(:page => @page, :per_page => @limit)
    elsif @type == 'metoo'
      @use_cases = UseCase.order('metoos_count DESC').where("metoos_count > ?", 0).paginate(:page => @page, :per_page => @limit)
    else
      @use_cases = UseCase.order('favorites_count DESC').where("funs_count > ?", 0).paginate(:page => @page, :per_page => @limit)
    end

    respond_to do |format|
      format.json { render json: @use_cases }
    end
  end

  # GET /use_cases/1
  # GET /use_cases/1.json
  def show
    @use_case = UseCase.find(params[:id])
    @favorites = @use_case.favorite

    # comments
    @favorites_count = Favorite.where("use_case_id = ?", params[:id]).length
    @funs_count = Fun.where("use_case_id = ?", params[:id]).length
    $metoos_count = Metoo.where("use_case_id = ?", params[:id]).length
    
    # comments of current user
    user_id = current_user.id
    user_favorite = @use_case.favorite.where('user_id = ?', user_id)
    user_fun = @use_case.fun.where('user_id = ?', user_id)
    user_metoo = @use_case.metoo.where('user_id = ?', user_id)
    
    # extend the use_case instance to include current user's comments
    @use_case.current_user_favorite = (user_favorite|false)
    @use_case.current_user_fun = (user_fun|false)
    @use_case.current_user_metoo = (user_metoo|false)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @use_case }
    end
  end

  # GET /use_cases/new
  # GET /use_cases/new.json
  def new
    @use_case = UseCase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @use_case }
    end
  end

  # GET /use_cases/1/edit
  def edit
    @use_case = UseCase.find(params[:id])
  end

  # POST /use_cases
  # POST /use_cases.json
  def create
    params[:use_case][:user_id] = current_user.id   # for test
    @use_case = UseCase.new(params[:use_case])

    respond_to do |format|
      if @use_case.save
        format.html { redirect_to @use_case, notice: 'Use case was successfully created.'}
        format.json { render json: @use_case, status: :created, location: @use_case }
      else
        format.html { render action: "new" }
        format.json { render json: @use_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /use_cases/1
  # PUT /use_cases/1.json
  def update
    @use_case = UseCase.find(params[:id])

    respond_to do |format|
      if @use_case.update_attributes(params[:use_case])
        format.html { redirect_to @use_case, notice: 'Use case was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @use_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /use_cases/1
  # DELETE /use_cases/1.json
  def destroy
    @use_case = UseCase.find(params[:id])
    @use_case.destroy

    respond_to do |format|
      format.html { redirect_to use_cases_url }
      format.json { head :no_content }
    end
  end

  # Grouped View
  def item
    @page, @limit = get_pagination_params(params)
    @grouped, @reduced = get_grouped_data('item', @page, @limit)

    respond_to do |format|
      format.html { render 'group.html.erb' }
      format.json { render json: @grouped }
    end
  end

  def purpose
    @page, @limit = get_pagination_params(params)
    @grouped, @reduced = get_grouped_data('purpose', @page, @limit)

    respond_to do |format|
      format.html { render 'group.html.erb' }
      format.json { render json: @grouped }
    end
  end

  private

  def get_grouped_data(key_name, page, limit)
    @use_cases = UseCase.order(key_name)
    @nested = Hash.new
    @reduced = Array.new

    @use_cases.each do |use_case|
      @key = use_case[key_name]

      if @nested[@key].nil?
        @nested[@key] = Array.new
      end

      @nested[@key].push(use_case)
    end

    @reduced = @nested.keys.paginate(:page => @page, :per_page => @limit)

    @paged_nested = Hash.new
    @reduced.each do |key|
      @paged_nested[key] = @nested[key]
    end

    return @paged_nested, @reduced
  end

end
