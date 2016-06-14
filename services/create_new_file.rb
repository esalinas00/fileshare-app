require 'http'

class CreateNewFile
  def self.call(folder_id:, filename:, description: nil, document:)
    file_url = "#{ENV['API_HOST']}/folders/#{folder_id}/files"
    response = HTTP.accept('application/json')
                   .post(file_url,
                         json: {
                           filename: filename,
                           description: description,
                           document: document
                           })
    new_file = response.parse
    response.code == 201 ? new_file : nil
  end
end
