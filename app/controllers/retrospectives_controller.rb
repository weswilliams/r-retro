class RetrospectivesController < ApplicationController
  # GET /retrospectives
  # GET /retrospectives.xml
  def index
    @retrospectives = Retrospective.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @retrospectives }
    end
  end

  # GET /retrospectives/1
  # GET /retrospectives/1.xml
  def show
    @retrospective = Retrospective.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @retrospective }
    end
  end

  # GET /retrospectives/new
  # GET /retrospectives/new.xml
  def new
    @retrospective = Retrospective.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @retrospective }
    end
  end

  # GET /retrospectives/1/edit
  def edit
    @retrospective = Retrospective.find(params[:id])
  end

  # POST /retrospectives
  # POST /retrospectives.xml
  def create
    @retrospective = Retrospective.new(params[:retrospective])

    respond_to do |format|
      if @retrospective.save
        format.html { redirect_to(@retrospective, :notice => 'Retrospective was successfully created.') }
        format.xml  { render :xml => @retrospective, :status => :created, :location => @retrospective }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @retrospective.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /retrospectives/1
  # PUT /retrospectives/1.xml
  def update
    @retrospective = Retrospective.find(params[:id])

    respond_to do |format|
      if @retrospective.update_attributes(params[:retrospective])
        format.html { redirect_to(@retrospective, :notice => 'Retrospective was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @retrospective.errors, :status => :unprocessable_entity }
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
      format.xml  { head :ok }
    end
  end
end
