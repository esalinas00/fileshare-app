class FileSharerCLI < Thor
  
  desc "folder FOLDERNAME", "Show List of Files inside FOLDERNAME"
  def folder(foldername)
    if CLIHelper.authenticated?
      session = CLIHelper.get_session
      puts "Welcome back #{session['current_account']['username']}"
    else
      puts "Please first use command login to authenticate in filesharer service"
    end
  end

   desc "folders ", "Show List of folders"
  def folders
    if CLIHelper.authenticated?
      session = CLIHelper.get_session
      puts "Welcome back #{session['current_account']['username']}"
    else
      puts "Please first use command login to authenticate in filesharer service"
    end
  end
end