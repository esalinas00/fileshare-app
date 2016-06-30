require 'http'
require 'base64'
# require 'fileutils'
require 'tempfile'

# Returns all configuration belonging to the folder
class GetFileDetails
  def self.call(folder_id:, file_id:)
    response = HTTP.get("#{ENV['API_HOST']}/folders/#{folder_id}/files/#{file_id}")
    # puts response.parse
    # response.code == 200 ? true : nil
    response.code == 200 ? download_file(response.parse) : nil
  end

  def self.call_by_name(folder_name:, file_name:)
    response = HTTP.get("#{ENV['API_HOST']}/foldersByName/#{folder_name}/filesByName/#{file_name}")
    # puts response.parse
    # response.code == 200 ? true : nil
    response.code == 200 ? download_file(response.parse) : nil
  end

  private_class_method

  def self.download_file(file_data)
    # FileUtils.mkdir_p('temp_downloaded')

    filename = file_data['data']['file']['data']['filename']
    # enc = file_data['data']['file']['data']['document_base64']
    # plain = Base64.strict_decode64(enc)

    enc = file_data['data']['file']['data']['document']
    plain = Base64.strict_decode64(enc)

    # path = "./temp_downloaded/#{filename}"
    #
    # plain = Base64.strict_decode64(enc)
    # File.open(path, 'w') {|f| f.write(plain)}
    t = Tempfile.new(filename)
    t.write(plain)
    t.rewind
    return filename, t
  end
end
