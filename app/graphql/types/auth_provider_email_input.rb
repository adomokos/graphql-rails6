module Types
  class AuthProviderEmailInput < BaseInputObject
    # The name is usually inferred by class name, but can be overriden
    graphql_name 'AUTH_PROVIDER_EMAIL'

    argument :email, String, required: true
    argument :password, String, required: true
  end
end
