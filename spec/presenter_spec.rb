# frozen_string_literal: true

require_relative '../lib/log_parser'

RSpec.describe Presenter do
  let(:visits) do
    { '/about' => { visit_count: 3, unique_ips: ['1.1.1.1', '8.8.8.8'], unique_visit_count: 2 } }
  end

  subject { Presenter.new }

  describe '#print_all_visits' do
    let(:expected_visits) do
      "\n     All Visits\n\n         /about     3 visits\n"
    end

    it 'should return formatted output of all visits' do
      expect { subject.print_all_visits(visits) }.to output(expected_visits).to_stdout
    end
  end

  describe '#unique_visits' do
    let(:expected_unique_visits) do
      "\n  Unique Visits\n\n         /about     2 visits\n"
    end
    it 'should return formatted output of unique visits' do
      expect { subject.print_unique_visits(visits) }.to output(expected_unique_visits).to_stdout
    end
  end

  describe '#introduction' do
    it 'should introduce the report' do
      expect { subject.print_introduction }.to output("##=> Log Report\n").to_stdout
    end
  end
end
