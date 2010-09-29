class SectionsController < ApplicationController

  def add
      @retrospective = Retrospective.find(params[:retrospective_id].to_i)
      @section = Section.new
      @section.retrospective = @retrospective
      @section.title = params[:title] == nil ?
              "Section#{Section.where("retrospective_id = ?", @retrospective.id).size + 1}" :
              params[:title]

      respond_to do |format|
        if @section.save
          format.html { redirect_to(retrospective_path(@retrospective), :notice => 'added section!') }
          format.xml { render :xml => @sections }
        else
          format.html { redirect_to(retrospective_path(@retrospective), :notice => 'failed to add section!') }
        end
      end

  end

  # GET /sections
  # GET /sections.xml
  def index
    if is_request_for_valid_retrospective
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

    if is_request_for_valid_retrospective(:redirect_url => retrospective_url(params[:retrospective_id]))
      respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @section }
      end
    end
  end

  # GET /sections/new
  # GET /sections/new.xml
  def new
    if is_request_for_valid_retrospective
      @section = Section.new
      @section.retrospective = Retrospective.find(params[:retrospective_id])

      respond_to do |format|
        format.html # new.html.erb
        format.xml { render :xml => @section }
      end
    end
  end

  # GET /sections/1/edit
  def edit
    is_request_for_valid_retrospective(:redirect_url => retrospectives_url)    
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

  def move_item_to
    @section = Section.find(params[:id])
    @item = Item.find(/^.*_item.*_(\d+)/.match(params[:item_id])[1].to_i)
    @from_section = @item.section
    @section.items << @item
    respond_to do |format|
      if @section.save
        format.js
      else
        format.js { redirect_to(retrospective_path(@section.retrospective), :notice => 'failed to move item!') }
      end
    end

  end

  def update_title
    @section = Section.find(params[:id])
    @section.title = params[:value]
    respond_to do |format|
      if @section.save
        format.js { render :inline => @section.title }
      else
        format.js { redirect_to(retrospective_path(@section.retrospective), :notice => 'failed to update title!') }
      end
    end

  end
  private

  def is_request_for_valid_retrospective(options = {})

    puts "redirect to #{options[:redirect_url]}"
    redirect_url = options[:redirect_url] || retrospectives_url

    begin
      @retrospective = Retrospective.find(params[:retrospective_id])
      @section = Section.find(params[:id]) if (params[:id])  
    rescue ActiveRecord::RecordNotFound
      logger.error "attempted to access section information for invalid retrospective #{params[:retrospective_id]}"
      redirect_to redirect_url, :notice => "The retrospective or section you requested is no longer available."
      false
    else
      true
    end
  end
end
