class ItemsController < ApplicationController
  # GET /items
  # GET /items.xml
  def index
    section_id = params[:section_id]
    @items = Item.find_all_by_section_id(section_id)

    @section = Section.find section_id

    respond_to do |format|
      format.html
      # index.html.erb
      format.xml { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html
      # show.html.erb
      format.xml { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new
    @item.section = Section.find(params[:section_id])

    respond_to do |format|
      format.html
      # new.html.erb
      format.xml { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  def add
    @section = Section.find(params[:section_id])
    @item = Item.new
    @item.section = @section
    @item.value = get_non_null_value_param()

    respond_to do |format|
      if @item.save
        format.js
      else
        format.js { redirect_to(retrospective_path(@section.retrospective), :notice => 'failed to add item!') }
      end
    end
  end

  def vote_for
    @item = Item.find(params[:id])
    @item.item_votes << ItemVote.new
    respond_to do |format|
      if @item.save
        format.js
      else
        format.js { redirect_to(retrospective_path(@item.section.retrospective), :notice => 'failed to add item vote!') }
      end
    end
  end

  def remove_vote
    @item = Item.find(params[:id])
    item_vote = @item.item_votes.pop
    respond_to do |format|
      if item_vote != nil && item_vote.destroy
        format.js { render :action => :vote_for }
      else
        format.js { redirect_to(retrospective_path(@item.section.retrospective), :notice => 'failed to remove item vote!') }
      end
    end
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])
    @item.section = Section.find(params[:section_id])

    respond_to do |format|
      if @item.save
        format.html { redirect_to(retrospective_path(@item.section.retrospective), :notice => 'Item was successfully created.') }
        format.xml { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_value
    if is_request_for_valid_item
      @item.value = get_non_null_value_param()

      respond_to do |format|
        if @item.save
          format.js { render :inline => @item.value }
        else
          format.js { redirect_to(retrospective_path(@item.section.retrospective), :notice => 'failed to update value!') }
        end
      end
    end
  end

  def refresh_value
    @item = Item.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def remove_from_group
    @item = Item.find(params[:id])
    @group = @item.group
    @item.group = nil
    respond_to do |format|
      if @item.save
        format.js
      else
        format.js { redirect_to(retrospective_path(@item.section.retrospective), :notice => 'failed to remove item from group!') }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to(retrospective_path(@item.section.retrospective), :notice => 'Item was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @section = Section.find(params[:section_id])
    @item.destroy
    @group_id = @item.group ? @item.group.id : 'x'

    respond_to do |format|
      format.html { redirect_to(retrospective_url(@item.section.retrospective)) }
      format.js
      format.xml { head :ok }
    end
  end

  private

  def is_request_for_valid_item()

    item_id = params[:id]
    begin
      @item = Item.find(item_id)
    rescue ActiveRecord::RecordNotFound
      logger.error "attempt to access invalid item #{item_id}"
      @bad_item_id = item_id
      @bad_section_id = params[:section_id]
      @groups = Retrospective.find(params[:retrospective_id]).groups
      
      respond_to do |format|
        format.js { render :action => :update_value_error }
      end
      false
    else
      true
    end
  end

  def get_non_null_value_param
    value = params[:value]
    value = 'double click to edit' if !value || value.strip.length == 0
    value
  end

end
