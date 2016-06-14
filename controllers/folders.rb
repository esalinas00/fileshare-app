require 'sinatra'
require 'faker'

# Base class for FileShare Web Application
class ShareFilesApp < Sinatra::Base
  get '/accounts/:username/folders' do
    if @current_account && @current_account['username'] == params[:username]
      @folders = GetAllFolders.call(current_account: @current_account,
                                      auth_token: session[:auth_token])
    end
    @folders ? slim(:all_folders) : redirect('/login')
  end

  post '/accounts/:username/folders' do
    folders_url = "/accounts/#{@current_account['username']}/folders"
    if @current_account && @current_account['username'] == params[:username]
      # TODO Created folder logic
      # get User ID
      # user_id = GetUserID.call(username: @current_account['username'])
      folders_url = "/accounts/#{@current_account['username']}/folders"
      filename = "#{Faker::App.name}"

      new_folder = CreateNewFolder.call(
        owner: @current_account,
        name: filename,
        folder_url: nil)

      if new_folder
        flash[:notice] = 'The folder was successfully created!'
        redirect folders_url + "/#{new_folder['id']}"
      else
        flash[:error] = 'Failed to create folder!'
        redirect "/accounts/#{params[:username]}/folders"
      end
    end
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
