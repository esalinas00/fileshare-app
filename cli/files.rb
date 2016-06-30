require 'mimemagic'
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
	      
	      File.open(output_path,"w") do |f|
		  		f.truncate(0)
				  f.write(temp_file.read)
				end

				puts "File downloaded"
				temp_file.unlink
	    rescue => e
	      logger.error "GET FILE FAILED: #{e}"
	      flash[:error] = "Could not get that file"
	      redirect @folder_url
	    end
    end
  end

  desc "upload FOLDER_NAME SOURCE_PATH", "UploadFile"
  def upload(folder_name, source_path)
  	begin
  		file = File.read(source_path)
  		filename = File.basename(source_path)
  		type = MimeMagic.by_path(source_path)

      new_file = CreateNewFile.call_by_name(
        folder_name: folder_name,
        filename: filename ,
        description: type,
        document: file)

      puts 'Here is your new file!'
      
    rescue => e
      puts 'Something went wrong -- we will look into it!'
      puts e.message
    end
  end
end