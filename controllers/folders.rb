require 'sinatra'

# Base class for FileShare Web Application
class ShareFilesApp < Sinatra::Base
  get '/accounts/:username/folders' do
    if @current_account && @current_account['username'] == params[:username]
      @folders = GetAllFolders.call(current_account: @current_account,
                                      auth_token: session[:auth_token])
    end

    @folders ? slim(:all_folders) : redirect('/login')
  end

  get '/accounts/:username/folders/:folder_id' do
    if @current_account && @current_account['username'] == params[:username]
      @folder = GetFolderDetails.call(folder_id: params[:folder_id],
                                        auth_token: session[:auth_token])
      if @folder
        slim(:folder)
      else
        flash[:error] = 'We cannot find this folder in your account'
        redirect "/accounts/#{params[:username]}/folders"
      end
    else
      redirect '/login'
    end
  end
end
