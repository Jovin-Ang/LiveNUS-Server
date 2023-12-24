module Devise::Api::Responses::TokenResponseDecorator
  def body
    return default_body.merge({
                                username: resource_owner.username,
                                first_name: resource_owner.first_name,
                                last_name: resource_owner.last_name,
                              })
  end
end