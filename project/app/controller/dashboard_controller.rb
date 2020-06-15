class Dashboard_controller < Application_Controller 

    get '/clients' do 
    authenticate
    @user = current_user
    erb :'/user_page/clients'
    end

    get '/clients/new' do 
    authenticate
    erb :'/user_page/new_client'
    end

    post '/clients' do 
    authenticate
    authenticate_title
    client = Client.new(name:params[:name], industry:params[:industry], priority:params[:priority])
    client.save
    if client.id != nil
        @user = current_user
        @user.clients << client
        redirect '/clients'
    else
        redirect '/dashboard'
    end
    end

    get '/client/:id' do 
    authenticate
    authenticate_client
    @user = current_user
    @client = @user.clients.find_by(id:params[:id])
    erb :'/user_page/client' 
    end

    get "/client/:id/edit" do 
    authenticate
    authenticate_client
    authenticate_title
    @user = current_user
    @client = @user.clients.find_by(id:params[:id])
    erb :"user_page/edit_client"
    end

    patch '/client/edit' do 
    authenticate 
    authenticate_title
    @client = Client.find_by(employee_id:current_user.id)
    @client.priority = params[:priority]
    @client.industry = params[:industry]
    @client.save
    redirect '/clients'
    end

    get '/client/:id/delete' do 
    authenticate 
    authenticate_client
    authenticate_title
    @user = current_user
    @client = @user.clients.find_by(id:params[:id])
    @client.delete
    redirect '/clients'
    end

    post '/search/title' do 
    authenticate
    @titles = Employee.select{|c|c.title == params[:title]}
    erb :"user_page/title"
    end

    post '/search/division' do 
    authenticate
    @division = Employee.select{|c|c.division == params[:division]}
    erb :"user_page/division"
    end

    get '/employees/all' do 
    authenticate 
    is_admin?
    @employees = Employee.select{|c|c.admin != true}
    erb :"/user_page/all_employees"
    end

    get '/employees/:id' do 
    authenticate 
    is_admin?
    @employee = Employee.find_by(id:params[:id])
    erb :"/user_page/employee"
    end

    get '/employees/:id/delete' do 
    authenticate
    is_admin?
    @employee = Employee.find_by(id:params[:id])
    @employee.delete
    redirect '/employees/all'
    end

end
