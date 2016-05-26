require 'http'

# Returns all folders belonging to an account
class GetFolderDetails
  def self.call(folder_id:, auth_token:)
    response = HTTP.auth("Bearer #{auth_token}")
                   .get("#{ENV['API_HOST']}/folders/#{folder_id}")
    response.code == 200 ? extract_folder_details(response.parse) : nil
  end

  private

  def self.extract_folder_details(folder_data)
    folder = folder_data['data']
    content = folder_data['relationships']

    files = content.map do |f|
      {
        id: f['id'],
        name: f['data']['name'],
        description: f['data']['description']
      }
    end

    { id: folder['id'],
      name: folder['attributes']['name'],
      folder_url: folder['attributes']['folder_url'],
      files: files }
  end
end
