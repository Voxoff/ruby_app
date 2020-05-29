#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './lib/log_parser.rb'

if ARGV[0].nil?
  puts 'Usage: ./parser.rb filename'
  return -1
end

log_parser = LogParser.new(ARGV[0])

log_parser.print_introduction
log_parser.print_all_visits
log_parser.print_unique_visits
