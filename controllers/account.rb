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

  post '/accounts/:username/folders/:folder_id/files' do
    if @current_account && @current_account['username'] == params[:username]
      # File.open('uploads/' + params['fileToUpload'][:filename], "w") do |f|
      #   f.write(params['fileToUpload'][:tempfile].read)
      # end

      folder_url = "/accounts/#{@current_account['username']}/folders/#{params[:folder_id]}"

      # get User ID
      # user_id = GetUserID.call(username: @current_account['username'])
      # puts user_id

      begin
        new_file = CreateNewFile.call(
          folder_id: params[:folder_id],
          filename: params['fileToUpload'][:filename],
          description: params['fileToUpload'][:type],
          document: params['fileToUpload'][:tempfile].read)

        flash[:notice] = 'Here is your new file!'
        redirect folder_url
        # redirect folder_url + "/files/#{new_file['id']}"
      rescue => e
        flash[:error] = 'Something went wrong -- we will look into it!'
        logger.error "NEW FILE FAIL: #{e}"
        redirect folder_url
      end

    end
  end
end
