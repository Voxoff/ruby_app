# frozen_string_literal: true

# Presents data from a log parser
class Presenter
  def print_all_visits(visits)
    puts
    puts 'All Visits'.rjust(15)
    puts
    visits.each do |page, data|
      puts "#{page.rjust(15)} #{data[:visit_count].to_s.rjust(5)} visits"
    end
  end

  def print_unique_visits(unique_visits)
    puts
    puts 'Unique Visits'.rjust(15)
    puts
    unique_visits.each do |page, data|
      puts "#{page.rjust(15)} #{data[:unique_visit_count].to_s.rjust(5)} visits"
    end
  end

  def print_introduction
    puts '##=> Log Report'.rjust(15)
  end
end
