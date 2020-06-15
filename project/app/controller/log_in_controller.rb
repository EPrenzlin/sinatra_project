class Log_in_controller < Application_Controller 

    get '/' do 
        erb :"./homepage/index"
        end
        
        get '/signup' do 
        erb :"/homepage/signup"
        end
        
        get '/login' do 
        erb :"/homepage/login"
        end
        
        post '/login' do 
        @user = Employee.find_by(name:params[:name])
         if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/dashboard"
        else
            redirect "/"
         end
        end
        
        post '/signup' do 
        @user = Employee.new(name:params[:name],password:params[:password], division:params[:division], title:params[:title]) 
        if @user.save
            redirect "/login"
        else
            redirect "/signup"
        end
        end
        
        get '/dashboard' do 
        @user = current_user
        if logged_in?
            erb :"/user_page/dashboard"
        else
            redirect :"/" 
        end
        end
        
        get '/logout' do 
        session.clear
        redirect "/"
        end
        

end