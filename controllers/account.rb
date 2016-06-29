require 'sinatra'

# Base class for ShareFile Web Application
class ShareFilesApp < Sinatra::Base
  get '/accounts/:username' do
    if @current_account && @current_account['username'] == params[:username]
      @auth_token = session[:auth_token]
      @pk = nil
      slim(:account)
    else
      slim(:login)
    end
  end

  post '/accounts/:username/pk' do
    if @current_account && @current_account['username'] == params[:username]
      begin
        new_file = CreatePublicKey.call(
          owner: @current_account,
          document: params['fileToUpload'][:tempfile].read)

        flash[:notice] = 'Public Key Added!'
        redirect folder_url
      rescue => e
        flash[:error] = 'Something went wrong -- we will look into it!'
        logger.error "NEW FILE FAIL: #{e}"
        redirect folder_url
      end

    end
  end
end
