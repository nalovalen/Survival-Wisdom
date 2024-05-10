require 'sinatra'
require 'sinatra/activerecord'

enable :sessions #esto era para mostrar el nombre de usuario en account

set :database_file, './config/database.yml'
set :public_folder, 'assets'

require './models/user'
require './models/question'

class App < Sinatra::Application
  def initialize(app = nil)
    super()
  end

  get '/home' do
    if current_user
      erb :'home/home', locals: { user: current_user }
    else
      redirect '/login'
    end
  end


  get '/login' do

    erb :'login/index', locals: { error: "" }
  end

  post '/login' do
    username = params[:first]
    password = params[:password]

    user = User.authenticate(username, password)

    if user
      session[:user_id] = user.id # Almacena el ID de usuario en la sesión
      redirect '/home'
    else
      # Credenciales inválidas, renderiza nuevamente el formulario de inicio de sesión con un mensaje de error
      erb :'login/index', locals: { error: "Credenciales inválidas. Por favor, inténtalo de nuevo." }
    end
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      nil
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
    redirect '/login'
  end

  get '/users' do
    @users = User.all
    erb :'users/users'
  end

  get '/skills' do
    if current_user
      erb :'home/skills', locals: { user: current_user }
    else
      redirect '/login'
    end
  end

  get '/keep_it_alive' do
    if current_user
      erb :'home/keep_it_alive', locals: { user: current_user }
    else
      redirect '/login'
    end
  end

  get '/stats' do
    if current_user
      erb :'home/stats', locals: { user: current_user }
    else
      redirect '/login'
    end
  end

  get '/about' do
    if current_user
      erb :'home/about', locals: { user: current_user }
    else
      redirect '/login'
    end
  end

  get '/account' do
    if current_user
      erb :'home/account', locals: { user: current_user }
    else
      redirect '/login'
    end
  end

  get '/test' do
    @questions = Question.all
    erb :'users/test'
  end
end





# @user = User.where(username: username).first
#if @user.password == password
#else
#end