require 'http'

class CreateNewFolder
  def self.call(owner:, name:, folder_url:)
    response = HTTP.post("#{ENV['API_HOST']}/accounts/#{owner['id']}/folders",
                         json: {name: name, folder_url: folder_url })
    new_folder = response.parse
    response.code == 201 ? new_folder : nil
  end
end
