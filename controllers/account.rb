require 'sinatra'

# Base class for ShareFile Web Application
class ShareFilesApp < Sinatra::Base
  get '/accounts/:username' do
    if @current_account && @current_account['username'] == params[:username]
      @auth_token = session[:auth_token]
      
      @pk = GetPublicKey(
        current_account: @current_account,
        auth_token: session[:auth_token])
      
      puts 'Account'
      puts @current_account
      puts @pk
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

        if new_file
          flash[:notice] = 'Public Key Added!'
        else
          flash[:error] = 'Error importing public key. Please try again'
        end
        
      rescue => e
        flash[:error] = 'Something went wrong -- we will look into it!'
        logger.error "NEW FILE FAIL: #{e}"
      end
      
      redirect "/accounts/#{params[:username]}"
    end
  end
end
