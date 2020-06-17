class Application_Controller < Sinatra::Base 

set :views, Proc.new { File.join(root, "../views") }

configure do 
    enable :sessions
    set :session_secret, ENV["SESSION_SECRET"]
    disable :show_exceptions  
end


helpers do 
    def current_user
    Employee.find_by(id:session[:user_id])
    end

    def logged_in? 
    !!current_user 
    end
    
    def authenticate
    if logged_in? == true
        true
    # elsif
    #      is_admin?
    #     true 
    else
        redirect '/logout'
    end
    end

    def authenticate_client
    if current_user.clients.include?(Client.find_by(id:params[:id]))
        true 
    elsif current_user.admin == true 
        true 
    else
        redirect '/dashboard' 
    end
    end
    
    def authenticate_title 
    if current_user.title == "Managing Director"
        true 
    else
        redirect '/dashboard'
        end
    end
    
    def is_admin? 
    if current_user.admin == true
        true 
    else 
        redirect '/dashboard'
    end
    end

end


not_found do 
erb :'error/error_page'
end

end