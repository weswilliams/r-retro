class RetrospectivesController < ApplicationController

  before_filter :init_cookies

  def auto_refresh
    is_request_for_valid_retrospective
    cookies[:auto_fresh] = toggle_auto_refresh_cookie
    respond_to do |format|
      format.html  { redirect_to(retrospective_path(@retrospective), :notice => 'auto refresh updated!') }
    end
  end

  def change_theme
    theme = params[:theme]
    cookies[:theme] = theme
    respond_to do |format|
      format.html { redirect_to({:action => 'show', :id => params[:id], :theme => theme}, :notice => 'theme changed') }
    end
  end

  def update_title
    if is_request_for_valid_retrospective()
      @retrospective = Retrospective.find(params[:id])
      @retrospective.title = params[:value]
      respond_to do |format|
        if @retrospective.save
          format.js { render :inline => @retrospective.title }
        else
          format.js { redirect_to(retrospective_path(@retrospective), :notice => 'failed to update title!') }
        end
      end
    end

  end

  # GET /retrospectives/1/refresh
  def refresh
    if is_request_for_valid_retrospective()
      @retrospective = Retrospective.find(params[:id])
      @section = Section.find(params[:section_id])
      respond_to do |format|
        format.js
      end
    end
  end

  # GET /retrospectives/1/refresh_groups
  def refresh_groups
    if is_request_for_valid_retrospective()
      @retrospective = Retrospective.find(params[:id])
      respond_to do |format|
        format.js
      end
    end
  end

  # GET /retrospectives
  # GET /retrospectives.xml
  def index
    @retrospectives = Retrospective.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /retrospectives/1
  # GET /retrospectives/1.xml
  def show
    if is_request_for_valid_retrospective(true)
      respond_to do |format|
        format.html # show.html.erb
        format.text { render :content_type => 'text/plain', :action => 'text' }
        format.xml { render :xml => @retrospective }
      end
    end
  end

  # GET /retrospectives/new
  # GET /retrospectives/new.xml
  def new
    @retrospective = Retrospective.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @retrospective }
    end
  end

  # GET /retrospectives/1/edit
  def edit
    is_request_for_valid_retrospective
  end

  # POST /retrospectives
  # POST /retrospectives.xml
  def create
    @retrospective = Retrospective.new(params[:retrospective])

    respond_to do |format|
      if @retrospective.save
        format.html { redirect_to(@retrospective, :notice => 'Retrospective was successfully created.') }
        format.xml { render :xml => @retrospective, :status => :created, :location => @retrospective }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @retrospective.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /retrospectives/1
  # PUT /retrospectives/1.xml
  def update
    if is_request_for_valid_retrospective

      respond_to do |format|
        if @retrospective.update_attributes(params[:retrospective])
          format.html { redirect_to(@retrospective, :notice => 'Retrospective was successfully updated.') }
          format.xml { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml { render :xml => @retrospective.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /retrospectives/1
  # DELETE /retrospectives/1.xml
  def destroy
    @retrospective = Retrospective.find(params[:id])
    @retrospective.destroy

    respond_to do |format|
      format.html { redirect_to(retrospectives_url) }
      format.xml { head :ok }
    end
  end

  private

  def is_request_for_valid_retrospective(require_title=false)
    begin
      @retrospective = Retrospective.find(params[:id])
      is_request_for_valid_retrospective_with_title if require_title
    rescue ActiveRecord::RecordNotFound
      logger.error "attempt to access invalid retrospective #{params[:id]}"
      redirect_to retrospectives_url, :notice => 'The retrospective you requested in no longer available.'
      false
    rescue RuntimeError
      logger.error "attempt to access retrospective by id without a title"
      redirect_to retrospectives_url, :notice => 'The retrospective you requested in no longer available.'
      false
    else
      true
    end
  end

  def is_request_for_valid_retrospective_with_title()
    if params[:id] != @retrospective.to_param
      raise "id is missing the title"
    end
  end

  def toggle_auto_refresh_cookie
    auto_refresh = cookies[:auto_fresh]
    if TrueClass.to_s == auto_refresh
      auto_refresh = FalseClass.to_s
    else
      auto_refresh = TrueClass.to_s
    end
    auto_refresh
  end

  def init_cookies
    cookies[:theme] = 'default' if !cookies[:theme]
    @theme = cookies[:theme]

    cookies[:auto_fresh] = TrueClass.to_s if cookies[:auto_fresh] == nil
    @auto_fresh = true if FalseClass.to_s == cookies[:auto_fresh]
  end
end
