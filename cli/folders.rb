class FileSharerCLI < Thor
  
  desc "folder FOLDER_ID", "Show List of Files inside FOLDER_ID"
  def folder(folder_id)
    if CLIHelper.authenticated?
      session = CLIHelper.get_session
      folder = GetFolderDetails.call(folder_id: folder_id,
                                      auth_token: session['auth_token'])

      puts '-----------------------------------------------'
      puts "-- #{folder['id']}. #{folder['name']}"
      folder['files'].each do |file|
        puts "  -- #{file['data']['filename']}"
      end
      puts '-----------------------------------------------'
      
    end
  end

   desc "folders ", "Show List of folders"
  def folders
    if CLIHelper.authenticated?
      session = CLIHelper.get_session
      folders = GetAllFolders.call(current_account: session['current_account'],
                                      auth_token: session['auth_token'])

      puts '---------------List of Folder------------------'
      folders.each do |folder|
        puts "-- #{folder[:id]}. #{folder[:name]}"
      end
      puts '-----------------------------------------------'
    end
  end
end