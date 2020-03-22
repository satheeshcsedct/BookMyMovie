# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
  # Theater
  theater_list = YAML.load_file("#{Rails.root}/db/theaters.yml")
  theater_list.values.each do |theater_params|
    Theater.find_or_create_by(theater_params)
  end

  # Movie
  movies_list = YAML.load_file("#{Rails.root}/db/movies.yml")
  movies_list.values.each do |movie_params|
    Movie.find_or_create_by(movie_params)
  end

  # TicketFee
  ticket_fees = YAML.load_file("#{Rails.root}/db/ticket_fees.yml")
  ticket_fees.values.each do |ticket_params|
    TicketFee.find_or_create_by(ticket_params)
  end

  def get_ticket_fee(date)
    beginning_of_day = date.beginning_of_day
    case date
    when beginning_of_day...(beginning_of_day + 12.hours)
      TicketFee.find_by_show_type('morning')&.id
    when (beginning_of_day + 12.hours)...(beginning_of_day + 16.hours)
      TicketFee.find_by_show_type('afternoon')&.id
    when (beginning_of_day + 16.hours)...(beginning_of_day + 21.hours)
      TicketFee.find_by_show_type('evening')&.id
    else
      TicketFee.find_by_show_type('night')&.id
    end
  end

  # ShowTiming
  (Time.now.beginning_of_day.to_i..Time.now.end_of_day.to_i).step(5.minutes) do |date|
    date = Time.at(date)
    ShowTiming.find_or_create_by(start_time: date, ticket_fee_id: get_ticket_fee(date))
  end

  # TheaterShows
  Theater.find_each do |theater|
    theater.show_timings << ShowTiming.unscoped.order('RAND()').first(6)
  end

  # Release
  Theater.find_each do |theater|
    movies = Movie.order('RAND()').first(6)
    movies.each do |movie|
      language = Release.languages.values[rand(Release.languages.values.size)]
      Release.find_or_create_by(theater_id: theater.id, movie_id: movie.id, language: language, start_date: Date.today, end_date: (Date.today + rand(20..40).days))
    end
  end

  # Discount
  discounts = YAML.load_file("#{Rails.root}/db/discounts.yml")
  discounts.values.each do |discount_params|
    Discount.find_or_create_by(discount_params)
  end
end
