module MomentumCms
  module Authentication
    module ApiAuthentication
      extend ActiveSupport::Concern

      included do
        before_action :set_cors_headers

        def respond_to_options_request
          head(:ok) if request.request_method == "OPTIONS"
        end

        def set_cors_headers
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
          headers['Access-Control-Request-Method'] = '*'
          headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, http_authorization'
        end

      end

      def authenticate
        true
      end

    end
  end
end