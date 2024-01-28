module StatusUtils
  def get_is_active(status : String) : Bool
    is_active = if status == "active"
                  true
                else
                  false
                end
    is_active
  end
end
