class UseCasesController < ApplicationController
  helper :all
  before_filter :require_login, :only => [:new, :edit, :create, :update]
  # GET /use_cases
  # GET /use_cases.json
  def index
    @page, @limit = get_pagination_params(params)

    # parameter: user_group
    if params[:user_group]
      @use_cases = UseCase.filter_by_user_group(params[:user_group])
    else
      @use_cases = UseCase.all
    end

    # if user_id is provided, show only the user's use cases
    # it discards the previous sorting/filtering settings
    if params[:user_id]
      @use_cases = UseCase.where("user_id = ?", params[:user_id])
    end

    # parameter: type
    if params[:type]
      type = params[:type].to_s

      @use_cases = case type
            when 'item' then @use_cases.sort_by { |use_case| use_case.item.downcase }
            when 'purpose' then @use_cases.sort_by { |use_case| use_case.purpose.downcase }
            when 'time' then @use_cases.sort_by(&:created_at).reverse
            else @use_cases
        end
    end

    # pagination
    if @use_cases
      @use_cases = @use_cases.paginate(:page => @page, :per_page => @limit)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @use_cases }
    end
  end
  
  # use_case가 받은 comment 순서대로 정렬
  def comment
    @page, @limit = get_pagination_params(params)
    
    if params[:type]
      @type = params[:type].to_s
    else
      @type = "wow"
    end
    
    @use_cases = UseCase.all.sort_by { |use_case| use_case[@type + 's_count'] }.reverse
    
    # pagination
    if @use_cases
      @use_cases = @use_cases.paginate(:page => @page, :per_page => @limit)
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @use_cases }
    end
  end

  def top
    @page, @limit = get_pagination_params(params)

    # parameter: user_group
    if params[:user_group]
      @use_cases = UseCase.filter_by_user_group(params[:user_group])
    else
      @use_cases = UseCase.all
    end

    # parameter: type
    # default ordering is by 'wow'
    params[:type] ||= 'wow'
    @type = params[:type].to_s
    if @type == 'wow'
      @temp = @use_cases.select{ |use_case| use_case.wows_count > 0 }
      @use_cases = @temp.sort_by(&:wows_count).reverse
    elsif @type == 'metoo'
      @temp = @use_cases.select{ |use_case| use_case.metoos_count > 0 }
      @use_cases = @temp.sort_by(&:metoos_count).reverse
    end

    # pagination
    if @use_cases
      @use_cases = @use_cases.paginate(:page => @page, :per_page => @limit)
    end

    respond_to do |format|
      format.json { render json: @use_cases }
    end
  end

  # newn API
  def groups
    @page, @limit = get_pagination_params(params)

    # parameter: user_group
    if params[:user_group]
      @use_cases = UseCase.filter_by_user_group(params[:user_group])
    else
      @use_cases = UseCase.all
    end

    # parameter: field
    params[:type] ||= "item"
    @field = params[:type].to_s
    if @field.eql?("item")
      @use_cases.sort_by(&:item)
    elsif @field.eql?("purpose")
      @use_cases.sort_by(&:purpose)
    end

    # start grouping
    @temp = Hash.new
    @use_cases.each do |use_case|
      @title = use_case[@field]

      if @temp[@title].nil?
        @temp[@title] = Array.new
      end

      @temp[@title].push(use_case)
    end

    @paged_keys = @temp.keys.paginate(:page => @page, :per_page => @limit)

    @groups = Array.new
    @paged_keys.each do |title|
      @group = Hash.new
      @group[:title] = title
      @group[:children] = @temp[title]

      @groups.push(@group)
    end

    respond_to do |format|
      format.json { render json: @groups }
    end
  end

  # GET /use_cases/1
  # GET /use_cases/1.json
  def show
    @use_case = UseCase.find(params[:id])

    # 코멘트 갯수 가져옴
    @favorites_count = Favorite.where("use_case_id = ?", params[:id]).length
    @wows_count = Wow.where("use_case_id = ?", params[:id]).length
    $metoos_count = Metoo.where("use_case_id = ?", params[:id]).length

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

  private
end