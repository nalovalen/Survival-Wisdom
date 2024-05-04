require 'sinatra/base'



class App < Sinatra::Application
  def initialize(app = nil)
    super()
  end

  set :public_folder, 'assets'
  get '/login' do
    puts "Hola"  
    erb :index
  end

  post '/login' do
    username = params[:first]
    password = params[:password]

    @user = User.where(username: username).first
    
    if @user.password == password
    else
    end
    # Aquí podrías agregar lógica para verificar las credenciales del usuario
    erb :home
    
end

get '/register' do
    erb :register
end


post '/register' do
    username = params[:first]
    password = params[:password]
    
    # Aquí podrías agregar lógica para verificar las credenciales del usuario
    
    "¡Hola, #{username}! te registraste correctamente."
end

  get '/' do
    'Welcome'
  end
end