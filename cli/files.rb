class FileSharerCLI < Thor
  
  desc "dowload FILE_PATH OUTPUT_PATH", "DownloadFile"
  def download(folder_path, output_path)
    if CLIHelper.authenticated?
      session = CLIHelper.get_session
      
    end
  end
end