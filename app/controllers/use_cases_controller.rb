class UseCasesController < ApplicationController
  helper :all
  before_filter :require_login, :only => [:new, :edit, :create, :update]
  # GET /use_cases
  # GET /use_cases.json
  def index
    @use_cases = UseCase.paginate(:page => @page, :per_page => @limit).order('id DESC')
    @use_cases = UseCase.paginate(:page => @page, :per_page => @limit).order('id DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @use_cases }
    end
  end

  # GET /use_cases/1
  # GET /use_cases/1.json
  def show
    @use_case = UseCase.find(params[:id])

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
    params[:use_case][:user_id] = current_user.id

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
  def product
    @use_cases = UseCase.paginate(:page => @page, :per_page => @limit)
    @grouped, @reduced = get_grouped_data('product', @page)

    respond_to do |format|
      format.html { render 'group.html.erb' }
      format.json { render json: @grouped }
    end
  end

  def function
    @use_cases = UseCase.paginate(:page => @page, :per_page => @limit)
    @grouped, @reduced = get_grouped_data('function', @page)

    respond_to do |format|
      format.html { render 'group.html.erb' }
      format.json { render json: @grouped }
    end
  end

  def user
    @use_cases = UseCase.paginate(:page => @page, :per_page => @limit)
    @grouped, @reduced = get_grouped_data('user_id', @page)

    respond_to do |format|
      format.html { render 'group.html.erb' }
      format.json { render json: @grouped }
    end
  end

  private

  def get_grouped_data(key_name, page)
    @reduced = UseCase.group(key_name).page(page)
    @nested = Hash.new

    @reduced.each do |use_case|
      @key = use_case[key_name]

      if @nested[@key].nil?
        @nested[@key] = Array.new
      end

      @data = UseCase.where(key_name + " = ?", @key)
      @nested[@key].push(@data)
    end

    return [@nested, @reduced]
  end

end
