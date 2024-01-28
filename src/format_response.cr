module FormatResponse
  def format_response(status : Int32, message : String, data)
    json({status: status, message: message, data: data})
  end
end
