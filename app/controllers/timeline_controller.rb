class TimelineController < ApplicationController

  skip_before_action :verify_authenticity_token 

  def show_timeline_form
  end	

  def create
  	if params[:name].present?
      if params[:task_id].present?
        timeline = Timeline.where(:id => params[:task_id]).first
      else
  		  timeline = Timeline.new
      end
  		timeline.name = params[:name]
  		timeline.description = params[:description]
  		timeline.start_date = params[:start_date]
  		timeline.end_date = params[:end_date]
  		timeline.added_by = params[:added_by]
  		if timeline.save
  			# render text: 'success'
        render "show_graph" 
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
      @timeline = Timeline.where(:id => params[:task_id]).first
      if @timeline.destroy
        # render plain: 'success'
        render "show_graph"
      end
    end
  end

  def show_graph
    
  end
end