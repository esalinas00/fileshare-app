require 'http'

# Returns all folders belonging to an account
class AddCollaboratorToFolder
  def self.call(collaborator_email:, folder_id:)
    collaborator_url = "#{ENV['API_HOST']}/folders/#{folder_id}/collaborators"

    response = HTTP.accept('application/json')
                   .post(collaborator_url,
                         json: { email: collaborator_email })

    response.code == 201 ? response.parse : nil
  end
end
