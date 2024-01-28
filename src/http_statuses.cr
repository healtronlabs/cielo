module HttpStatuses
  module StatusCodes
    NOT_FOUND             = 404
    BAD_REQUEST           = 400
    OK                    = 200
    CREATED               = 201
    UNAUTHORIZED          = 401
    FORBIDDEN             = 403
    CONFLICT              = 409
    INTERNAL_SERVER_ERROR = 500
  end

  module StatusMessages
    NOT_FOUND             = "Not Found"
    BAD_REQUEST           = "Bad request"
    OK                    = "Ok"
    CREATED               = "Created"
    UNAUTHORIZED          = "Unauthorized"
    FORBIDDEN             = "Forbidden"
    CONFLICT              = "Conflict"
    INTERNAL_SERVER_ERROR = "Internal Server Error"
  end
end
