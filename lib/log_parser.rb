# frozen_string_literal: true

require_relative 'presenter'

# Analyses and stores data from a log file, hands off to a presenter
class LogParser
  attr_reader :visits, :presenter

  def initialize(file)
    @visits = {}
    @presenter = Presenter.new
    analyse_logs(file)
  end

  def print_unique_visits
    unique_visits = sort_visits_by(:unique_visit_count)
    presenter.print_unique_visits(unique_visits)
  end

  def print_all_visits
    visits = sort_visits_by(:visit_count)
    presenter.print_all_visits(visits)
  end

  def print_introduction
    presenter.print_introduction
  end

  private

  def analyse_logs(file)
    File.foreach(file) do |line|
      page, ip = line.split(' ')

      visits[page] ||= { visit_count: 0, unique_ips: [], unique_visit_count: 0 }

      visits[page][:visit_count] += 1
      add_unique_visits(page, ip)
    end
  end

  def sort_visits_by(sortable)
    visits.sort_by { |_page, data| -data[sortable] }
  end

  def add_unique_visits(page, ip)
    return if visits[page][:unique_ips].include?(ip)

    visits[page][:unique_visit_count] += 1
    visits[page][:unique_ips] << ip
  end
end
