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


  it 'says "Hello World"' do
    get '/test'

    expect(last_response).to be_ok
    expect(last_response.body). to eq('Hello World')
  end
end