class GroupsController < ApplicationController

  def add
      @retrospective = Retrospective.find(params[:retrospective_id].to_i)
      @group = Group.new
      @group.retrospective_id = @retrospective.id
      @group.title = params[:title] == nil ?
              "Group#{Group.where("retrospective_id = ?", @retrospective.id).size + 1}" :
              params[:title]

      respond_to do |format|
        if @group.save
          format.js
        else
          format.js { redirect_to(retrospective_path(@retrospective), :notice => 'failed to add group!') }
        end
      end

  end

  def update_title
    @retrospective = Retrospective.find(params[:retrospective_id].to_i)
    @group = Group.find(params[:id].to_i)
    @group.title= params[:value]

    respond_to do |format|
      if @group.save
        format.js { render :inline => @group.title }
      else
        format.js { redirect_to(retrospective_path(@retrospective), :notice => 'failed to update title!') }
      end
    end

  end

end