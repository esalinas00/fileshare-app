require 'http'

# Returns an authenticated user, or nil
class FindAuthenticatedAccount
  HOST = 'http://fileshare-api.herokuapp.com/api/v1'

  def self.call(username:, password:)
    response = HTTP.get("#{ENV['API_HOST']}/accounts/#{username}/authenticate",
                        params: {password: password})
    response.code == 200 ? JSON.parse(response) : nil
  end
end
