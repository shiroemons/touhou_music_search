module AppleMusic
  class Token
    class << self
      attr_reader :private_key, :key_id, :team_id

      def token
        load_data
        unless private_key.nil? || key_id.nil? || team_id.nil?
          token = Redis.current.get("token")
          token ||= create_token
          token
        else
          raise "PRIVATE_KEY、KEY_ID、TEAM_IDを設定してください"
        end
      end

      private

      def load_data
        @private_key = ENV["PRIVATE_KEY"]
        @key_id = ENV["KEY_ID"]
        @team_id = ENV["TEAM_ID"]
      end

      def create_token
        hours_to_live = 24

        time_now = Time.now.to_i
        expired_term = hours_to_live * 3600
        time_expired = Time.now.to_i + expired_term
        algorithm = 'ES256'

        headers = {
          'typ': 'JWT',
          'kid': key_id
        }

        payload = {
          'iss': team_id,
          'exp': time_expired,
          'iat': time_now
        }

        ecdsa_key = OpenSSL::PKey::EC.new private_key
        ecdsa_key.check_key

        token = JWT.encode payload, ecdsa_key, algorithm, header_fields=headers
        Redis.current.set("token", token, ex: expired_term)
        token
      end
    end
  end
end
