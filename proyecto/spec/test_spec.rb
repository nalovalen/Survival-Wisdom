ENV['APP_ENV'] = 'test'

require_relative '../server.rb'
require 'rspec'
require 'rack/test'

RSpec.describe 'The Server' do
  include Rack::Test::Methods

  def app
    # Sinatra::Appplication
    App
  end

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

  describe 'POST /register' do
    it 'registers a new user' do
      post '/register', first: 'newusera', password: 'password', nickname: 'newnickname'
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

  #Unauthorized User:
  #Simulate an unauthorized user by not setting any user session in the test.
  #Try to access a protected route, like /home.
  #Assert that the response redirects to the login page (/login).
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

end