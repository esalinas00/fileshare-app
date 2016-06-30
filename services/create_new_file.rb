require 'http'
require 'base64'

class CreateNewFile
  def self.call(folder_id:, filename:, description: nil, document:)
    file_url = "#{ENV['API_HOST']}/folders/#{folder_id}/files"
    base64_encode_document = Base64.strict_encode64(document)
    response = HTTP.accept('application/json')
                   .post(file_url,
                         json: {
                           filename: filename,
                           description: description,
                           document: base64_encode_document
                           })
    new_file = response.parse
    response.code == 201 ? new_file : nil
  end

  def self.call_by_name(folder_name:, filename:, description: nil, document:)
    file_url = "#{ENV['API_HOST']}/foldersByName/#{folder_name}/files"
    base64_encode_document = Base64.strict_encode64(document)
    response = HTTP.accept('application/json')
                   .post(file_url,
                         json: {
                           filename: filename,
                           description: description,
                           document: base64_encode_document
                           })
    new_file = response.parse
    response.code == 201 ? new_file : nil
  end
end
