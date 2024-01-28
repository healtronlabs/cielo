module Dates
  def calculate_created_time_ago(created_at : Time) : String
    differnce_created_at_time = Time.utc - created_at
    days = differnce_created_at_time.days
    hours = differnce_created_at_time.total_hours
    minutes = differnce_created_at_time.total_minutes
    joined_time_ago = "A few seconds ago"
    if days >= 1
      joined_time_ago = "#{days.round.to_i} days ago"
    elsif days < 1
      if hours < 1
        joined_time_ago = "#{minutes.round.to_i} minutes ago"
      elsif hours >= 1
        joined_time_ago = "#{hours.round.to_i} hours ago"
      elsif minutes < 1
        joined_time_ago = "A few seconds ago"
      end
    end
    joined_time_ago
  end

  def prepare_date_range_different_days(
    starting_time : String,
    ending_time : String? = Time.utc.to_s
  ) : Tuple(Time, Time)
    casted_starting = Time.parse(starting_time, "%Y-%m-%d", Time::Location::UTC)
    casted_ending = Time.parse(ending_time, "%Y-%m-%d", Time::Location::UTC)
    starting_year = casted_starting.year
    starting_month = casted_starting.month
    starting_day = casted_starting.day
    ending_year = casted_ending.year
    ending_month = casted_ending.month
    ending_day = casted_ending.day
    start_of_the_day = Time.utc(starting_year, starting_month, starting_day, 0, 0, 0)
    end_of_the_day = Time.utc(ending_year, ending_month, ending_day, 23, 59, 59)
    {start_of_the_day, end_of_the_day}
  end

  def prepare_date_range_same_day(
    date : String? = Time.utc.to_s
  ) : Tuple(Time, Time)
    casted = Time.parse(date, "%Y-%m-%d", Time::Location::UTC)
    year = casted.year
    month = casted.month
    day = casted.day
    start_of_the_day = Time.utc(year, month, day, 0, 0, 0)
    end_of_the_day = Time.utc(year, month, day, 23, 59, 59)
    {start_of_the_day, end_of_the_day}
  end

  def set_end_date(end_time : String | Nil) : String
    res = if end_time
            end_time
          else
            Time.utc.to_s
          end
  end

  def format_date_time(date_time : Time) : String
    date_time.to_s.gsub(" ", "T").sub(%r{TUTC$}, "")
  end

  def parse_date_time(formatted_time : String) : Time
    formatted_time = formatted_time.gsub("T", " ").sub(%r{\.\d+(\+[\d:]+|Z)$}, " UTC")
    begin
      time = Time.parse!(formatted_time, "%Y-%m-%d %H:%M:%S %:z")
    rescue ex : Exception
      puts ex
      return Time.utc
    end

    return time
  end
end
