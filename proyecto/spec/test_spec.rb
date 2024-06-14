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
  describe 'GET /home' do
    it 'redirects unauthorized users to login' do
      get '/home'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /skills' do
    it 'redirects unauthorized users to login' do
      get '/skills'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /skill/shelter' do
    it 'redirects unauthorized users to login' do
      get '/skills/shelter'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /skill/guideShelter.pdf' do
    it 'redirects unauthorized users to login' do
      get '/skills/guideShelter.pdf'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /skill/fire' do
    it 'redirects unauthorized users to login' do
      get '/skills/fire'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /skill/guideFire.pdf' do
    it 'redirects unauthorized users to login' do
      get '/skills/guideFire.pdf'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /skill/food' do
    it 'redirects unauthorized users to login' do
      get '/skills/food'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /skill/guideFood.pdf' do
    it 'redirects unauthorized users to login' do
      get '/skills/guideFood.pdf'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /skill/medicine' do
    it 'redirects unauthorized users to login' do
      get '/skills/medicine'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /skill/guideMedicine.pdf' do
    it 'redirects unauthorized users to login' do
      get '/skills/guideMedicine.pdf'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /skill/water' do
    it 'redirects unauthorized users to login' do
      get '/skills/water'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /skill/guideWater.pdf' do
    it 'redirects unauthorized users to login' do
      get '/skills/guideWater.pdf'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /keep_it_alive' do
    it 'redirects unauthorized users to login' do
      get '/keep_it_alive'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /keep_it_alive/init' do
    it 'redirects unauthorized users to login' do
      get '/keep_it_alive/init'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /about' do
    it 'redirects unauthorized users to login' do
      get '/about'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /account' do
    it 'redirects unauthorized users to login' do
      get '/account'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
    end
  end

  describe 'GET /keep_it_alive/playing' do
    it 'redirects unauthorized users to login' do
      get '/keep_it_alive/playing'
      expect(last_response.status).to eq(302) # Found (redirect)
      expect(last_response.headers['Location']).to include('/login')
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

end