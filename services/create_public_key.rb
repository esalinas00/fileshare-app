require 'http'
require 'base64'

class CreatePublicKey
  def self.call(owner:, document:)
    api = "#{ENV['API_HOST']}/accounts/#{owner['id']}/pk"
    base64_encode_document = Base64.strict_encode64(document)
    response = HTTP.accept('application/json')
                   .post(api,
                         json: {
                           public_key: base64_encode_document
                           })
    pk = response.parse
    response.code == 201 ? pk : nil
  end
end
