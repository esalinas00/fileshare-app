require 'http'
require 'base64'
# Returns all folders belonging to an account
class GetPublicKey
  def self.call(current_account:, auth_token:)
    response = HTTP.auth("Bearer #{auth_token}")
                   .get("#{ENV['API_HOST']}/accounts/#{current_account['id']}/pk")

    response.code == 200 ? extract_publicKey(response.parse) : nil
  end

  private_class_method

  def self.extract_publicKey(response)
    # Convert from base64
    if response['public_key']
      Base64.strict_decode64(response['public_key'])
    end
  end

end