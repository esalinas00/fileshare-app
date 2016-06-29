require 'http'

# Returns all folders belonging to an account
class GetPublicKey
  def self.call(current_account:, auth_token:)
    response = HTTP.auth("Bearer #{auth_token}")
                   .get("#{ENV['API_HOST']}/accounts/#{current_account['id']}/pk")

    response.code == 200 ? response.parse : nil
  end

end