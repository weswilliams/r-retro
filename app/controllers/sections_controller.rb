class SectionsController < ApplicationController

  # GET /sections
  # GET /sections.xml
  def index
    begin
      Retrospective.find(params[:retrospective_id])
    rescue ActiveRecord::RecordNotFound
      logger.error "attempted to access section information for invalid retrospective #{params[:retrospective_id]}"
      redirect_to retrospectives_url, :notice => "The retrospective or section you requested is no longer available."
    else
      @sections = Section.find_all_by_retrospective_id(params[:retrospective_id])

      respond_to do |format|
        format.html # index.html.erb
        format.xml { render :xml => @sections }
      end
    end

  end

  # GET /sections/1
  # GET /sections/1.xml
  def show

    begin
      @section = Section.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid section #{params[:id]}"
      redirect_to retrospective_url, :notice => "The section you requested is no longer available."
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @section }
      end
    end
  end

  # GET /sections/new
  # GET /sections/new.xml
  def new
    @section = Section.new
    @section.retrospective = Retrospective.find(params[:retrospective_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @section }
    end
  end

  # GET /sections/1/edit
  def edit
    @section = Section.find(params[:id])
  end

  # POST /sections
  # POST /sections.xml
  def create
    @section = Section.new(params[:section])

    respond_to do |format|
      if @section.save
        format.html { redirect_to(@section.retrospective, :notice => 'Section was successfully created.') }
        format.xml { render :xml => @section, :status => :created, :location => @section }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sections/1
  # PUT /sections/1.xml
  def update
    @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        format.html { redirect_to(retrospective_path(@section.retrospective), :notice => 'Section was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.xml
  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html { redirect_to(retrospective_sections_url) }
      format.xml { head :ok }
    end
  end


end
