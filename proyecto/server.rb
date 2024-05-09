require 'sinatra'
require 'sinatra/activerecord'

set :database_file, './config/database.yml'
set :public_folder, 'assets'

require './models/user'

class App < Sinatra::Application
  def initialize(app = nil)
    super()
  end

  get '/home' do
    erb :'home/home'
  end


  get '/login' do  
    erb :'login/index'
  end

  post '/login' do
    username = params[:first]
    password = params[:password]
    # Aquí podrías agregar lógica para verificar las credenciales del usuario
    redirect '/home'
    
  end

  get '/register' do
    erb :'login/register'
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

  get '/users' do
    @users = User.all
    erb :'users/users'
  end

  get '/skills' do 
    erb :'home/skills'
  end 

  get '/keep_it_alive' do
    erb :'home/keep_it_alive'
  end

  get '/stats' do 
    erb :'home/stats'
  end

  get '/about' do 
    erb :'home/about'
  end

  get '/account' do 
    erb :'home/account'
  end

end





# @user = User.where(username: username).first   
#if @user.password == password
#else
#end