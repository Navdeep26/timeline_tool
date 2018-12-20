class TimelineController < ApplicationController

  skip_before_action :verify_authenticity_token 

  def dashboard
    if session[:admin_login].present? && session[:admin_login] == "yes"
      redirect_to '/authentication'
    else
      render "dashboard", :layout => false 
    end
  end

  def show_timeline_form
    if !session[:user].present?
      redirect_to "/"
    end
  end	

  def create
  	if params[:name].present?
      if params[:task_id].present?
        if params[:public].present? && params[:public] == "on"
          timeline_array = Timeline.where(:id => params[:task_id]).update_all(name: params[:name], description: params[:description], start_date: params[:start_date], end_date: params[:end_date], :show_all => "1", :user_id => session[:user] )
        else
          timeline_array = Timeline.where(:id => params[:task_id]).update_all(name: params[:name], description: params[:description], start_date: params[:start_date], end_date: params[:end_date], :show_all => "0", :user_id => session[:user] )
        end
        
            render :partial => "graph"
      else
  		  timeline = Timeline.new
        user = User.where(:id => session[:user]).first
    		timeline.name = params[:name]
    		timeline.description = params[:description]
    		timeline.start_date = params[:start_date]
    		timeline.end_date = params[:end_date]
        timeline.added_by = "#{user.first_name } #{user.last_name} " 
        if params[:public].present? && params[:public] == "on"
    		  timeline.show_all = "1"
        else
          timeline.show_all = "0"
        end
        timeline.user_id = user.id
    		if timeline.save
          if params[:task_id].present?
            render :partial => "graph" 
          else
            render "show_graph"
          end
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
    if params[:user_id].present?
      render :partial => "graph"
    end
  end

  def show_graph
    if !session[:user].present?
      redirect_to "/"
    end
  end

  def authentication
    # raise "#{session[:admin_login]}"
    if session[:user].present?
      redirect_to "/show_timeline_form"
    else
      if session[:admin_login].present? && session[:admin_login] == "yes"
        render "log_in", :layout => false
      else
        redirect_to "/"
      end
    end
  end

  def sign_up
    if session[:admin_login].present? && session[:admin_login] == "yes"
        render "sign_up", :layout => false
      else
        redirect_to "/"
      end
  end

  def create_user
    if params[:first_name] && params[:last_name] && params[:email].present?
      user = User.new
      user.first_name = params[:first_name]
      user.last_name = params[:last_name]
      user.email = params[:email]
      user.password = Base64.encode64(params[:password])
      if user.save
        session[:user] = user.id
        render plain: "OK"
      end
    end
  end

  def verify_user
    if params[:email].present? && params[:password].present?
      user = User.where(:email => params[:email]).first
      if user.present? && Base64.decode64(user.password) == params[:password]
        session[:user] = user.id
        redirect_to "/show_timeline_form"
      else
        render :plain => "Not valid account"
      end
    end
  end

  def sign_out
    # reset_session
    session.delete('user')
    redirect_to "/"
  end

  def admin_login
    if params[:email].present? && params[:password].present?
      if params[:email] == "timelinetool@byteally.com" && params[:password] == "godzilla@123"
        session[:admin_login] = "yes"
        render plain: "OK"
        # redirect_to "/authentication"
      else
        render plain: "Not valid account"
      end
    end
  end

end
