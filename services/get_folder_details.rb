require 'http'

# Returns all folders belonging to an account
class GetFolderDetails
  def self.call(folder_id:, auth_token:)
    response = HTTP.auth("Bearer #{auth_token}")
                   .get("#{ENV['API_HOST']}/folders/#{folder_id}")
    response.code == 200 ? extract_folder_details(response.parse) : nil
  end

  private_class_method

  def self.extract_folder_details(folder_data)
    content = folder_data['relationships']['files']

    files = content.map do |f|
      { 'id' => f['id'],
        'filename' => f['data']['filename'],
        'description' => f['data']['description'] }
    end

    { 'id' => folder_data['id'],
      'name' => folder_data['attributes']['name'],
      'folder_url' => folder_data['attributes']['folder_url'],
      'files' => files }
      .merge(folder_data['attributes'])
      .merge(folder_data['relationships'])
  end

  # def self.extract_folder_details(folder_data)
  #   folder = folder_data['data']
  #   content = folder_data['relationships']
  #   # {"type"=>"folder", "id"=>2, "attributes"=>{"name"=>"Gembucket", "folder_url"=>nil}, "relationships"=>{"owner"=>nil, "collaborators"=>[], "files"=>[]}}
  #   files = content.map do |f|
  #     {
  #       id: f['id'],
  #       filename: f['data']['filename'],
  #       description: f['data']['description']
  #     }
  #   end
  #
  #   { id: folder['id'],
  #     name: folder['attributes']['name'],
  #     folder_url: folder['attributes']['folder_url'],
  #     files: files }
  # end
end
