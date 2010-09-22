class GroupsController < ApplicationController

  def add
      @retrospective = Retrospective.find(params[:retrospective_id])
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

end