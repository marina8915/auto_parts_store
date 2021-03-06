require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.to_s + '/swagger'

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:to_swagger' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      consumes: ['application/json'],
      produces: ['application/json'],
      paths: {}
    }
  }
end

def declare_auth_parameter
  parameter name: :Authorization, in: :header, schema: { type: :string }
end

def error_schema(status_code, label)
  response status_code, label do
    schema type: :object,
      properties: {
        messages: {
          type: :object,
          properties: {
            error_key: {
              type: :array,
              items: { type: :string }
            }
          }
        }
      }

    yield if block_given?

    run_test!
  end
end


def success_schema(status_code, label, properties)
  response status_code, label do
    schema type: :object, properties: properties

    yield if block_given?

    run_test!
  end
end
