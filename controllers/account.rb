require 'sinatra'

# Base class for ShareFilesApp Web Application
class ShareFilesApp < Sinatra::Base
  use Rack::Session::Cookie, coder: CookieEncoder.new,
                             let_coder_handle_secure_encoding: true

  set :views, File.expand_path('../../views', __FILE__)

  before do
    @current_account = session[:current_account]
  end

  get '/' do
    slim :home
  end
end


require 'sinatra'

# Base class for ShareFilesApp Web Application
class ShareFilesApp < Sinatra::Base
  get '/account/:username' do
    if @current_account && @current_account['username'] == params[:username]
      slim(:account)
    else
      slim(:login)
    end
  end

  get '/login/?' do
    slim :login
  end

  post '/login/?' do
    username = params[:username]
    password = params[:password]

    @current_account = FindAuthenticatedAccount.call(
      username: username, password: password)

    if @current_account
      session[:current_account] = @current_account
      slim :home
    else
      slim :login
    end
  end

  get '/logout/?' do
    @current_account = nil
    session[:current_account] = nil
    slim :login
  end
end
