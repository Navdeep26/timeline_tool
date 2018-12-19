Rails.application.routes.draw do
  get '/', to: 'timeline#dashboard' 
  get '/timeline/admin-login',  to: 'timeline#admin_login'
	get '/authentication', to: 'timeline#authentication' 
  get '/signUp', to: 'timeline#sign_up' 
  get '/sign-out', to: 'timeline#sign_out' 
  post '/timeline/create_user', to: 'timeline#create_user' 
  get '/timeline/log-in', to: 'timeline#verify_user'
  get 'show_timeline_form', to: 'timeline#show_timeline_form'
  get 'show_graph', to: 'timeline#show_graph'
  post 'timeline/edit', to: 'timeline#edit'
  post 'timeline/destroy', to: 'timeline#destroy'
  post 'timeline/filter_name', to: 'timeline#filter_name'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	post 'timeline/create', to: 'timeline#create' 
end
