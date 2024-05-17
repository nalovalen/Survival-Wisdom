require 'sinatra'
require 'sinatra/activerecord'


enable :sessions

set :database_file, './config/database.yml'
set :public_folder, 'assets'

require './models/user'
require './models/question'
require './models/option'
require './models/skill'
require './models/guide'
require './models/bar'
require './models/stat'

class App < Sinatra::Application
  def initialize(app = nil)
    super()
  end

  before do
    redirect '/login' unless ['/login', '/register'].include?(request.path_info) || current_user
  end

  get '/home' do
    erb :'home/home', locals: { user: current_user }
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
    nickname = params[:nickname]
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
      user.nickname = nickname
      user.save

      session[:user_id] = user.id
      stat = Stat.new
      stat.user_id = session[:user_id] # Asigna el ID del usuario
      stat.days = 0
      stat.save
      redirect '/login'

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
      erb :'home/skills', locals: { user: current_user }
  end

  get '/skill/shelter' do
    erb :'skill/shelter'
  end

  get '/skill/guideShelter.pdf' do
    send_file 'views\skill\guideShelter.pdf', :type => :pdf
  end

  get '/skill/fire' do
    erb :'skill/fire'
  end

  get '/skill/guideFire.pdf' do
    send_file 'views\skill\guideFire.pdf', :type => :pdf
  end

  get '/skill/food' do
    erb :'skill/food'
  end

  get '/skill/guideFood.pdf' do
    send_file 'views\skill\guideFood.pdf', :type => :pdf
  end

  get '/skill/medicine' do
    erb :'skill/medicine'
  end

  get '/skill/guideMedicine.pdf' do
    send_file 'views\skill\guideMedicine.pdf', :type => :pdf
  end

  get '/skill/water' do
    erb :'skill/water'
  end

  get '/skill/guideWater.pdf' do
    send_file 'views\skill\guideWater.pdf', :type => :pdf
  end

  get '/keep_it_alive' do
    if current_user
      erb :'home/keep_it_alive', locals: { user: current_user }
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
      erb :'home/account', locals: { user: current_user }
  end

  get '/test' do
    @questions = Question.all
    erb :'users/test'
  end

  get '/guiatest' do
    @skills = Skill.all
    erb :'users/guiatest'
  end

  get '/keep_it_alive/init' do
    # Recuperar todas las preguntas y opciones de la base de datos

    @questions = Question.all.order("RANDOM()").to_a.map(&:id)
    bars = Bar.all
    @current_user = current_user # Asegúrate de que current_user esté definido en algún lugar de tu código


    bars.each do |bar|
      if bar.name_bar == 'health'
      session[:health] = bar.value
      end
      if bar.name_bar == 'hunger'
        session[:hunger] = bar.value
      end
      if bar.name_bar == 'water'
        session[:water] = bar.value
      end
      if bar.name_bar == 'temperature'
        session[:temperature] = bar.value
      end
    end


    # Si no hay preguntas en la base de datos, mostrar un mensaje
    if @questions.empty?
      return "No hay preguntas disponibles."
    end
    session[:question] = @questions.shift
    session[:@questions]= @questions
    session[:days] = 0
    erb :'home/game'
  end

  get '/keep_it_alive/playing' do
    if session[:@questions].nil? || session[:@questions].empty?
      # Si no quedan preguntas en la sesión, vuelve a asignar todas las preguntas de manera aleatoria
      @questions = Question.all.order("RANDOM()")
      session[:@questions] = @questions.map(&:id)
    else
      # Si quedan preguntas en la sesión, sigue utilizando esas preguntas
      @questions = Question.where(id: session[:@questions])
    end

    session[:question] = session[:@questions].shift
    @current_user = current_user
    erb :'home/game'
  end



  post '/keep_it_alive/playing' do

    opcionelegida = params[:valor].to_i
    effects = Question.find(session[:question]).options[opcionelegida-1].effects

     if session[:health] + effects[0] >= 10
      session[:health] = 10
     else
      session[:health] += effects[0]
     end
     if session[:hunger] + effects[1] >= 10
      session[:hunger] = 10
     else
      session[:hunger] += effects[1]
     end
     if session[:water] + effects[2] >= 10
      session[:water] = 10
     else
      session[:water] += effects[2]
     end
     if session[:temperature] + effects[3] >= 10
      session[:temperature] = 10
     else
      session[:temperature] += effects[3]
     end


    puts "#{session[:health]},#{session[:hunger]},#{session[:water]},#{session[:temperature]}"
    if session[:health] <= 0 || session[:hunger] <= 0 || session[:water] <= 0 || session[:temperature] <= 0
      puts 'Anda a dormir gordito'
      stat = Stat.new
      stat.user_id = session[:user_id] # Asigna el ID del usuario
      stat.days = session[:days]
      stat.save


      erb :'home/gameover'
    else
      session[:days] += 1
      redirect '/keep_it_alive/playing'
    end
  end
end



# Maneja la solicitud POST para jugar de nuevo
post '/jugar-de-nuevo' do
  # Aquí puedes agregar la lógica para reiniciar el juego o redirigir a la página de inicio del juego
  # Por ejemplo, puedes reiniciar las variables de sesión y redirigir al usuario a la página de inicio
  session[:game_state] = nil # Reiniciar el estado del juego
  redirect to('/keep_it_alive/init') # Redirigir a la página de inicio del juego
end


# Maneja la solicitud GET para redirigir a /home cuando se hace clic en "Volver a Home"
get '/back-to-home' do
  redirect '/home' # Redirige al usuario a la página de inicio
end

get '/logout' do
  session.clear
  redirect '/login'
end