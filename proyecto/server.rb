require 'sinatra/base'

class App < Sinatra::Application
  set :public_folder, 'assets'  # Assuming your assets are in a folder named 'assets'

  get '/login' do  
    erb :index
  end
  post '/login' do
    username = params[:first]
    password = params[:password]

    # Aquí podrías agregar lógica para verificar las credenciales del usuario   
    "¡Hola, #{username}! ingresaste correctamente pasword #{password}."
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
 
end