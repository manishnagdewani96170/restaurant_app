module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        version 'v1', using: :path
        default_format :json
        format :json

        helpers do
          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
          end

          def logger
            Rails.logger
          end

        end

        # global exception handler, used for error notifications
        rescue_from ActiveRecord::RecordNotFound do |e|
          error!(message: e.message, status: 404)
        end

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          error!({ messages: e.full_messages }, status: 406)
        end
      end
    end
  end
end
