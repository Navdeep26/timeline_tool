class TimelineController < ApplicationController

  skip_before_action :verify_authenticity_token 

  def show_timeline_form
  end	

  def create
  	if params[:name].present?
      if params[:task_id].present?
        timeline_array = Timeline.where(:id => params[:task_id])
        timeline = timeline_array.first
      else
  		  timeline = Timeline.new
      end
  		timeline.name = params[:name]
  		timeline.description = params[:description]
  		timeline.start_date = params[:start_date]
  		timeline.end_date = params[:end_date]
  		timeline.added_by = params[:added_by]
  		if timeline.save
        if params[:task_id].present?
          render :partial => "graph" 
        else
          render "show_graph"
        end
  		end
  	end
  end

  def edit
    if params[:task_id].present?
      @timeline = Timeline.where(:id => params[:task_id]).first
      if @timeline.present?
        render "show_timeline_form", :layout => false
      end
    end
  end

  def destroy
    if params[:task_id].present?
      @timeline = Timeline.where(:id => params[:task_id])
      if @timeline.delete_all 
        # render "show_graph"
        render :partial => "graph" 
      end
    end
  end

  def filter_name
    if params[:filter_name].present?
      render :partial => "graph"
    end
  end

  def show_graph
    
  end
end
