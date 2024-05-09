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
    errors = false
    erb :'login/index'
  end

  post '/login' do
    username = params[:first]
    password = params[:password]

    user = User.authenticate(username, password)

    if user
      # Credenciales válidas, redirecciona a la página de inicio o realiza alguna otra acción
      redirect '/home'
    else
      # Credenciales inválidas, puedes renderizar nuevamente el formulario de inicio de sesión con un mensaje de error
      errors = true
      erb :'login/index'
    end
  end


  get '/register' do
    erb :'login/register'
  end


  post '/register' do
    username = params[:first]
    password = params[:password]

    # Verifica si ya existe un usuario con el mismo nombre de usuario en la base de datos
    existing_user = User.find_by(username: username)

    if existing_user
      # Si ya existe un usuario con el mismo nombre de usuario, puedes renderizar nuevamente el formulario de registro con un mensaje de error
      erb :'login/register', locals: { error: "El nombre de usuario ya está en uso. Por favor, elige otro nombre de usuario." }
    else
      # Si no existe un usuario con el mismo nombre de usuario, procede a crear uno nuevo y guardarlo en la base de datos
      #new_user = User.new(username: username, password: password)
      user = User.new
      user.username = username
      user.password = password
      user.save
      redirect '/home'

    end
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