module ApplicationHelper
  def display_show_time(show_timing)
    show_timing.start_time.strftime('%I:%M %p')
  end

  def available_seats(movie, theater, show_timing, date)
    total_booking = Booking.filtered_list_for(movie, theater, show_timing, date)&.count
    theater.seat_limit - total_booking
  end

  def availability_display_class(available_seats, theater_limit)
    percentage_available = (available_seats / theater_limit&.to_f) * 100
    case percentage_available
    when 0..25
      'text-danger'
    when 25..50
      'text-warning'
    when 50..75
      'text-info'
    else
      'text-success'
    end
  end
end
