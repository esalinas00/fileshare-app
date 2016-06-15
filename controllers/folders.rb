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
      folders_url = "/accounts/#{@current_account['username']}/folders"
      filename = "#{Faker::App.name}"

      new_folder = CreateNewFolder.call(
        owner: @current_account,
        name: filename,
        folder_url: nil)

      if new_folder
        flash[:notice] = "The folder '#{filename}' was successfully created!"
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

  post '/accounts/:username/folders/:folder_id/collaborators/?' do
    # halt_if_incorrect_user(params)

    collaborator = AddCollaboratorToFolder.call(
      collaborator_email: params[:email],
      folder_id: params[:folder_id])

    # puts "COLLAB REQUESTED: #{collaborator}"
    if collaborator
      account_info = "#{collaborator['username']} (#{collaborator['email']})"
      flash[:notice] = "Added #{account_info} to the vault"
    else
      flash[:error] = "Could not add #{params['email']} to the vault"
    end

    redirect back
  end

end
