struct Paginator
  getter path_to_next : String?
  getter path_to_previous : String?
  getter item_count : Int32
  getter total : Int32
  getter records_per_page : Int32

  def initialize(
    @path_to_next : String?,
    @path_to_previous : String?,
    @item_count : Int32,
    @total : Int32,
    @records_per_page : Int32
  )
  end
end
