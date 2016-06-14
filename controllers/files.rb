require 'sinatra'

# Base class for ConfigShare Web Application
class ShareFilesApp < Sinatra::Base
  get '/accounts/:username/folders/:folder_id/files/?' do
    folder_url = "/accounts/#{@current_account['username']}/folders/#{params[:folder_id]}"
    redirect folder_url
  end

  get '/accounts/:username/folders/:folder_id/files/:file_id' do
    # halt_if_incorrect_user(params)

    begin
      @folder_url = "/accounts/#{@current_account['username']}/folders/#{params[:folder_id]}"
      filename, temp_file = GetFileDetails.call(
        folder_id: params[:folder_id],
        file_id: params[:file_id])
      send_file(temp_file.path, :filename => filename, :disposition => 'attachment')
      # puts "FILE FOUND: #{temp_file}"
      temp_file.unlink
    rescue => e
      logger.error "GET FILE FAILED: #{e}"
      flash[:error] = "Could not get that file"
      redirect @folder_url
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
