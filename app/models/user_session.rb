class UserSession < Authlogic::Session::Base
  single_access_allowed_request_types :post
  def to_key
    new_record? ? nil : [self.send(self.class.primary_key)]
  end

  def persisted?
    false
  end
end
