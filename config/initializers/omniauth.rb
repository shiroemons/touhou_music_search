require 'omniauth'

OmniAuth.config.request_validation_phase = TokenVerifier.new