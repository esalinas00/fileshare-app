require 'sinatra'

# Base class for ShareFilesApp Web Application
class ShareFilesApp < Sinatra::Base
  enable :logging
  use Rack::Session::Cookie, secret: ENV['MSG_KEY']

  set :views, File.expand_path('../../views', __FILE__)

  before do
    @current_account = session[:current_account]
  end

  get '/' do
    APIServerWakeUp.call
    slim :home
  end
end
