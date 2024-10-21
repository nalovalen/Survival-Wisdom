# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'

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
require './authentication_controller'

# This module provides methods for handling user authentication,
# such as checking the current user and validating credentials.
module Authentication
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

# Clase Principal
class App < Sinatra::Application
  include Authentication

  use AuthController

  def initialize(_app = nil)
    super()
  end

  get '/home' do
    erb :'home/home', locals: { user: current_user }
  end

  post '/change_nickname' do
    new_nickname = params[:new_nickname]
    current_user = User.find(session[:user_id])
    # Actualiza el nickname del usuario actual
    current_user.update(nickname: new_nickname)
    # Guarda los cambios en la base de datos
    current_user.save
    # Redirige a la página de cuenta o a donde prefieras
    redirect '/account'
  end

  post '/change_password' do
    new_password = params[:new_password]
    current_user = User.find(session[:user_id])
    if new_password != ' ' && new_password != '' && new_password != BCrypt::Password.new(current_user.password)
      # Actualiza el pasword del usuario actual
      new_password_digest = BCrypt::Password.create(new_password)
      current_user.update(password: new_password_digest)
      # Guarda los cambios en la base de datos
      current_user.save
      # Redirige a la página de cuenta o a donde prefieras
      redirect '/logout'
    else
      erb :'home/account', locals: { error: 'Contraseña no valida.' }
    end
  end

  get '/' do
    if current_user.nil?
      redirect '/login'
    else
      redirect '/home'
    end
  end


  get '/skills' do
    erb :'home/skills', locals: { user: current_user }
  end

  # Muestra los pdf de las guias
  get '/skill/:guide.pdf' do
    file_path = "views\\skill\\#{params[:guide].capitalize}.pdf"
    send_file file_path, type: :pdf
  end

  # Ingresa a la guia que el usuario desee
  get '/skill/:id' do
    erb :"skill/#{params[:id]}"
  end


  get '/keep_it_alive' do
    erb :'home/keep_it_alive', locals: { user: current_user }
  end

  get '/about' do
    erb :'home/about', locals: { user: current_user }
  end

  get '/account' do
    erb :'home/account', locals: { user: current_user }
  end

  get '/leaderboard' do
    erb :'home/leaderboard', locals: { user: current_user }
  end

  # Inicializa la partida
  get '/keep_it_alive/init' do
    # Recuperar todas las preguntas y opciones de la base de datos

    @questions = Question.all.order('RANDOM()').to_a.map(&:id)
    bars = Bar.all
    @current_user = current_user # Asegúrate de que current_user esté definido en algún lugar de tu código

    session[:xray] = 0
    bars.each do |bar|
      session[:health] = bar.value if bar.name_bar == 'health'
      session[:hunger] = bar.value if bar.name_bar == 'hunger'
      session[:water] = bar.value if bar.name_bar == 'water'
      session[:temperature] = bar.value if bar.name_bar == 'temperature'
    end


    # Si no hay preguntas en la base de datos, mostrar un mensaje
    return 'No hay preguntas disponibles.' if @questions.empty?

    session[:question] = @questions.shift
    session[:@questions] = @questions
    session[:days] = 0
    session[:coins] = @current_user.coins
    erb :'home/game'
  end

  get '/keep_it_alive/playing' do
    if session[:@questions].nil? || session[:@questions].empty?
      # Si no quedan preguntas en la sesión, vuelve a asignar todas las preguntas de manera aleatoria
      @questions = Question.all.order('RANDOM()')
      session[:@questions] = @questions.map(&:id)
    else
      # Si quedan preguntas en la sesión, sigue utilizando esas preguntas
      @questions = Question.where(id: session[:@questions])
    end
    session[:xray] = 0
    session[:question] = session[:@questions].shift
    @current_user = current_user
    erb :'home/game'
  end


  # Es la partida a medida que va avanzando el usuario
  post '/keep_it_alive/playing' do
    opcionelegida = params[:valor].to_i
    effects = Question.find(session[:question]).options[opcionelegida - 1].effects
    question = Question.find(session[:question])
    if opcionelegida == 2
      question.rightclicks = question.rightclicks + 1
    else
      question.leftclicks = question.leftclicks + 1
    end
    question.save

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
    session[:xray] = 0

    if session[:health] <= 0 || session[:hunger] <= 0 || session[:water] <= 0 || session[:temperature] <= 0
      stat = Stat.new
      stat.user_id = session[:user_id] # Asigna el ID del usuario
      stat.days = session[:days]
      @current_user.coins = session[:coins]
      @current_user.save
      stat.save


      erb :'home/gameover'
    else
      session[:days] += 1
      session[:coins] += 1
      redirect '/keep_it_alive/playing'
    end
  end
  post '/keep_it_alive/comodin' do
    comodin_elegido = params[:comodin].to_i
    monedas = session[:coins]

    case comodin_elegido
    when 1
      if monedas >= 30
        # Comodin de Skip de carta
        session[:coins] -= 30

        if session[:@questions].nil? || session[:@questions].empty?
          # Si no quedan preguntas en la sesión, vuelve a asignar todas las preguntas de manera aleatoria
          @questions = Question.all.order('RANDOM()')
          session[:@questions] = @questions.map(&:id)
        else
          # Si quedan preguntas en la sesión, sigue utilizando esas preguntas
          @questions = Question.where(id: session[:@questions])
        end

        redirect '/keep_it_alive/playing'
      else
        # No hay suficientes monedas
        @error_message = 'No tienes suficientes monedas para usar este comodín.'
      end

    when 2
      # Comodin de Stat Boost
      if monedas >= 10
        session[:coins] -= 10
        session[:health] += rand(0..3)
        session[:hunger] += rand(0..3)
        session[:water] += rand(0..3)
        session[:temperature] += rand(0..3)
      else
        # No hay suficientes monedas
        @error_message = 'No tienes suficientes monedas para usar este comodín.'
      end

    when 3
      # Comodin de Xray
      if monedas >= 15
        session[:coins] -= 15
        session[:xray] = 1
      else
        # No hay suficientes monedas
        @error_message = 'No tienes suficientes monedas para usar este comodín.'
      end
    end
    erb :'home/game'
  end

  # Fin de la partida con el back-button:
  post '/keep_it_alive/end' do
    stat = Stat.new
    stat.user_id = session[:user_id]
    stat.days = session[:days]
    @current_user.coins = session[:coins]
    @current_user.save
    stat.save

    redirect '/home'
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

  get '/add_question' do
    erb :'home/add_question'
  end

  post '/add_question' do
    statement = params[:statement]
    difficulty = params[:difficulty]

    params[:descriptionL]
    params[:effectsL].split(',').map(&:strip).map(&:to_i)

    params[:descriptionR]
    params[:effectsR].split(',').map(&:strip).map(&:to_i)

    question = Question.new

    question.statement = statement
    question.typeCard = difficulty

    question.save

    question_id = question.id



    option_l = Option.new
    option_l.question_id = question_id
    option_l.description = descriptionL
    option_l.effects = effectsL


    option_r = Option.new
    option_r.question_id = question_id
    option_r.description = descriptionR
    option_r.effects = effectsR

    option_l.save
    option_r.save

    @success_message = 'The question was successfully added!'

    erb :'home/add_question'
  end

  get '/card-stats' do
    erb :'home/card-stats'
  end
end
