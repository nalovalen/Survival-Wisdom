ENV['APP_ENV'] = 'test'

require_relative '../server.rb'
require 'rspec'
require 'rack/test'
require 'spec_helper'

RSpec.describe 'The Server' do
  include Rack::Test::Methods

  def app
    # Sinatra::Appplication
    App
  end

  # Checkea si el usuario se loguea correctamente
  describe 'POST /login' do
    user = User.new
    user.username = 'testuser'
    user.password = 'password'
    user.nickname = 'nickname'
    user.save

    it 'logs in the user with correct credentials' do
      post '/login', first: 'testuser', password: 'password'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/home')
    end

    it 'renders login page with error on invalid credentials' do
      post '/login', first: 'testuser', password: 'wrongpassword'
      expect(last_response).to be_ok
      expect(last_response.body).to include('Credenciales inválidas')
    end
  end

  # Checkea si se registra bien el usuario
  describe 'POST /register' do
    it 'registers a new user' do
      post '/register', first: 'newuser1', password: 'password', nickname: 'newnickname'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/login')
    end

    it 'renders register page with error if username already taken' do
      user = User.new
      user.username = 'existinguser'
      user.password = 'password'
      user.nickname = 'nickname'
      user.save

      post '/register', first: 'existinguser', password: 'password', nickname: 'nickname'
      expect(last_response).to be_ok
      expect(last_response.body).to include("El nombre de usuario ya está en uso. Por favor, elige otro nombre de usuario.")
    end
  end

  # Checkea que no se pueda acceder a ciertas direcciones de la web sin haber iniciado sesion
  describe 'Unauthorized access' do
    rutas = [
      '/',
      '/home',
      '/skills',
      '/skills/shelter',
      '/skills/guideShelter.pdf',
      '/skills/fire',
      '/skills/guideFire.pdf',
      '/skills/food',
      '/skills/guideFood.pdf',
      '/skills/medicine',
      '/skills/guideMedicine.pdf',
      '/skills/water',
      '/skills/guideWater.pdf',
      '/keep_it_alive',
      '/keep_it_alive/init',
      '/about',
      '/account',
      '/keep_it_alive/playing'
    ]
    rutas.each do |ruta|
      describe "GET #{ruta}" do
        it 'redirects unauthorized users to login' do
          get ruta
          expect(last_response.status).to eq(302)
          expect(last_response.headers['Location']).to include('/login')
        end
      end
    end
  end

  describe 'GET /register' do
    it 'redirects normaly' do
      get '/register'
      expect(last_request.path).to eq('/register')
    end
  end

  describe 'GET /skills' do
    it 'redirects normaly' do
      post '/login', first: 'testuser', password: 'password'
      get '/skills'
      expect(last_request.path).to eq('/skills')
    end
  end

  describe 'GET /keep_it_alive' do
    it 'redirects normaly' do
      post '/login', first: 'testuser', password: 'password'
      get '/keep_it_alive'
      expect(last_request.path).to eq('/keep_it_alive')
    end
  end

  describe 'GET /about' do
    it 'redirects normaly' do
      post '/login', first: 'testuser', password: 'password'
      get '/about'
      expect(last_request.path).to eq('/about')
    end
  end

  describe 'GET /account' do
    it 'redirects normaly' do
      post '/login', first: 'testuser', password: 'password'
      get '/account'
      expect(last_request.path).to eq('/account')
    end
  end

  # Checkea que la partida se inicialice correctamente
  describe 'Keep It Alive' do
    describe 'GET /keep_it_alive/init' do
      it 'initializes the game session' do
        post '/login', first: 'testuser', password: 'password'

        env 'rack.session', {
            health: 5,
            hunger: 5,
            water: 5,
            temperature: 5,
            days: 0,
            question: nil,
            questions: nil,
          }

        def session
          last_request.env['rack.session']
        end

        get '/keep_it_alive/init'

        expect(last_response).to be_ok
        expect(session[:health]).to eq(10)
        expect(session[:hunger]).to eq(10)
        expect(session[:water]).to eq(10)
        expect(session[:temperature]).to eq(10)
        expect(session[:days]).to eq(0)
        expect(session[:question]).to be_present
      end
    end

    describe "POST /keep_it_alive/playing" do
      before do
        post '/login', first: 'testuser', password: 'password'

        # Set up the session
        env 'rack.session', {
          question: 1,
          health: 5,
          hunger: 5,
          water: 5,
          temperature: 5,
          days: 1,
          user_id: 1
        }
      end

      def session
        last_request.env['rack.session']
      end

      let(:effects) { [1, -1, 2, -2] } # Simula los efectos de la opción elegida

      before do
        allow(Question).to receive_message_chain(:find, :options).and_return([double(effects: effects)])
      end

      it "updates session correctly when effects are positive and negative" do
        post '/keep_it_alive/playing', params: { valor: 1 }
        expect(session[:health]).to eq(6)
        expect(session[:hunger]).to eq(4)
        expect(session[:water]).to eq(7)
        expect(session[:temperature]).to eq(3)
      end

      it "caps session values at 10" do
        allow(Question).to receive_message_chain(:find, :options).and_return([double(effects: [10, 10, 10, 10])])
        post '/keep_it_alive/playing', params: { valor: 1 }
        expect(session[:health]).to eq(10)
        expect(session[:hunger]).to eq(10)
        expect(session[:water]).to eq(10)
        expect(session[:temperature]).to eq(10)
      end

      it "renders gameover when any session value is 0 or below" do
        allow(Question).to receive_message_chain(:find, :options).and_return([double(effects: [-10, -10, -10, -10])])
        post '/keep_it_alive/playing', params: { valor: 1 }
        expect(last_response.status).to eq(200)
        expect(last_response.body).to include('GAME OVER')
      end
    end

  end

    # Si te deslogeas y queres entrar a una ruta no te tiene que dejar:
    describe 'User Logout' do
      it 'successfully logs out the user and redirects to login' do
        post '/login', first: 'testuser', password: 'password'
        expect(last_response).to be_redirect
        follow_redirect!

        get '/logout'
        expect(last_response).to be_redirect
        follow_redirect!
        expect(last_request.path).to eq('/login')

        get '/skills'
        expect(last_response.status).to eq(302)
        follow_redirect!
        expect(last_request.path).to eq('/login')

      end
    end

    # Verifica que la ruta raíz redirige correctamente
describe 'GET /' do
  it 'redirects to /login' do
    get '/'
    expect(last_response.status).to eq(302)
    expect(last_response.headers['Location']).to include('/login')
  end
end


describe 'Game Restart' do
  it 'resets the game state and redirects to the game init page' do
    #logeo el usuario:
    post '/login', first: 'testuser', password: 'password'
    # Realiza la solicitud POST para reiniciar el juego
    post '/jugar-de-nuevo'

    # Verifica la redirección
    expect(last_response).to be_redirect
    follow_redirect!

    # Verifica que la redirección lleve a la página de inicio del juego
    expect(last_request.path).to eq('/keep_it_alive/init')
  end
end


describe 'GET /back-to-home' do
  it 'redirects to the home page' do
    #logeo el usuario:
    post '/login', first: 'testuser', password: 'password'
    # Realiza una solicitud GET a la ruta /back-to-home
    get '/back-to-home'

    # Verifica que la respuesta sea una redirección
    expect(last_response).to be_redirect

    # Sigue la redirección
    follow_redirect!

    # Verifica que después de la redirección la URL sea /home
    expect(last_request.path).to eq('/home')
  end
end

describe 'GET /keep_it_alive/init' do
  context 'cuando no hay preguntas disponibles' do
    before do
      #logeo el usuario:
      post '/login', first: 'testuser', password: 'password'
      allow(Question).to receive(:all).and_return(double(order: [])) # Simula que no hay preguntas
      allow(Bar).to receive(:all).and_return([]) # Opcional: si también necesitas simular los bares
      get '/keep_it_alive/init'
    end

    it 'debe devolver un mensaje indicando que no hay preguntas disponibles' do
      expect(last_response.body.force_encoding('UTF-8')).to eq('No hay preguntas disponibles.')
    end
  end
end

end