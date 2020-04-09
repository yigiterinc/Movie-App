# Singleton wrapper for JWT related functionality
class JsonWebToken
  class << self
    def encode(payload, exp_time = 24.hours.from_now)
      payload[:exp_time] = exp_time.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new body
    rescue  # Catches if nil
      nil
    end
  end
end