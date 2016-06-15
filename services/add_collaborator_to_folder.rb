require 'http'

# Returns all folders belonging to an account
class AddCollaboratorToFolder
  def self.call(collaborator_email:, folder_id:, auth_token:)
    collaborator_url = "#{ENV['API_HOST']}/folders/#{folder_id}/collaborators"

    response = HTTP.accept('application/json')
                   .auth("Bearer #{auth_token}")
                   .post(collaborator_url, json: { email: collaborator_email })

    response.code == 201 ? response.parse : nil
  end
end
