class FileSharerCLI < Thor
  
  desc "dowload FILE_PATH OUTPUT_PATH", "DownloadFile"
  def download(folder_path, output_path)
    if CLIHelper.authenticated?
      session = CLIHelper.get_session
      folder_name = folder_path.split('/')[0]
      file_name = folder_path.split('/')[1]
      begin
	      filename, temp_file = GetFileDetails.call_by_name(
	        folder_name: folder_name,
	        file_name: file_name)
	      puts "File"
	      puts filename
	      puts temp_file
	      File.open(output_path,"w") do |f|
		  		f.truncate(0)
				  f.write(temp_file.read)
				end
				temp_file.unlink
	    rescue => e
	      logger.error "GET FILE FAILED: #{e}"
	      flash[:error] = "Could not get that file"
	      redirect @folder_url
	    end
    end
  end
end