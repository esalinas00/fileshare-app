require 'sinatra'

# Base class for ShareFile Web Application
class ShareFilesApp < Sinatra::Base
  get '/accounts/:username' do
    if @current_account && @current_account['username'] == params[:username]
      @auth_token = session[:auth_token]
      slim(:account)
    else
      slim(:login)
    end
  end
end
