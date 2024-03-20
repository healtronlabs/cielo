module Paginator
  struct PagesDto
    getter total_records : Int32
    getter records_per_page : Int32
    getter current_page : Int32
    getter total_pages : Int32

    def initialize(
      @total_records : Int32,
      @records_per_page : Int32,
      @current_page : Int32,
      @total_pages : Int32
    )
    end
  end

  def self.paginate_array(
    items : Array(T),
    records_per_page : Int32? = 10,
    current_page : Int32? = 1
  ) : Tuple(PagesDto, Array(T)) forall T
    total_pages = ((items.size / records_per_page).ceil).to_i32
    pages = PagesDto.new \
      total_records: items.size,
      current_page: current_page.positive? ? current_page : 1,
      records_per_page: records_per_page.positive? ? records_per_page : 10,
      total_pages: total_pages

    return {pages, Array(T).new} if (current_page > total_pages || !current_page.positive? || !records_per_page.positive?)

    start_index = (current_page - 1) * records_per_page
    end_index = start_index + records_per_page

    {pages, items[start_index...end_index]}
  end
end
