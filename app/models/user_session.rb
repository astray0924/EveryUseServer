class UserSession < Authlogic::Session::Base
  single_access_allowed_request_types :any
  find_by_login_method :find_by_email
  
  def to_key
    new_record? ? nil : [self.send(self.class.primary_key)]
  end

  def persisted?
    false
  end
end
