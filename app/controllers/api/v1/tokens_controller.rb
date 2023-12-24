class Api::V1::TokensController < Devise::Api::TokensController
  private
  def sign_up_params
    params.permit(:username, :first_name, :last_name, *resource_class.authentication_keys,
                  *::Devise::ParameterSanitizer::DEFAULT_PERMITTED_ATTRIBUTES[:sign_up]).to_h
  end
end