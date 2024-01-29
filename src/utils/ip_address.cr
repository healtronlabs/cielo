module IpAddress
  def transform_to_underscored(ip_address : String) : String
    ip_address.gsub(".", "_")
  end
end
