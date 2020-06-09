class Application_Controller < Sinatra::Base 

set :views, Proc.new { File.join(root, "../views") }

end