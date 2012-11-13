class ActiveSupport::TimeWithZone
  def as_json(options = {})
    strftime("%Y-%m-%dT%H:%M:%S")
  end
end