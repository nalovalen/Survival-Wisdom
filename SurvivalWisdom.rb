require 'sinatra'

get '/login' do
  erb :index
end

get '/register' do
    erb :register
end

post '/login' do
    username = params[:username]
    password = params[:password]
    
    # Aquí podrías agregar lógica para verificar las credenciales del usuario
    
    "¡Hola, #{username}! Tu contraseña es #{password}."
end

post '/register' do
    username = params[:username]
    password = params[:password]
    
    # Aquí podrías agregar lógica para verificar las credenciales del usuario
    
    "¡Hola, #{username}! te registraste correctamente."
end
