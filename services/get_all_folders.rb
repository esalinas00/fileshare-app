require 'http'

# Returns all folders belonging to an account
class GetAllFolders
  def self.call(current_account:, auth_token:)
    response = HTTP.auth("Bearer #{auth_token}")
                   .get("#{ENV['API_HOST']}/accounts/#{current_account['id']}/folders")
    response.code == 200 ? extract_folders(response.parse) : nil
  end

  private_class_method

  def self.extract_folders(folders)
    folders['data'].map do |proj|
      { id: proj['id'],
        name: proj['attributes']['name'],
        folder_url: proj['attributes']['folder_url'] }
    end
  end
end
