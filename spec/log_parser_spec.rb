# frozen_string_literal: true

require_relative '../lib/log_parser'
require_relative '../lib/presenter'

RSpec.describe LogParser do
  let(:log_file) { File.dirname(__FILE__) + '/fixtures/webserver.log' }

  let(:expected_results) do
    {
      '/contact' => { unique_ips: ['184.123.665.067'], unique_visit_count: 1, visit_count: 1 },
      '/help_page/1' => { unique_ips: ['126.318.035.038', '929.398.951.889'], unique_visit_count: 2, visit_count: 3 },
      '/home' => { unique_ips: ['184.123.665.067'], unique_visit_count: 1, visit_count: 1 }
    }
  end

  subject { described_class.new(log_file) }
  let(:presenter) { subject.presenter }

  describe '#initialize' do
    it 'should create a presenter' do
      expect_any_instance_of(Presenter).to receive(:initialize)
      subject
    end

    it 'should analyse the log' do
      expect_any_instance_of(described_class).to receive(:analyse_logs)
      subject
    end
  end

  describe '#sort_visits_by' do
    it 'sorts visits by a chosen key in the data hash' do
      expect(subject.send(:sort_visits_by, :visit_count).first.first).to eq '/help_page/1'
    end
  end

  describe '#add_unique_visits' do
    let(:add_unique_visit) { subject.send(:add_unique_visits, visit[:page], visit[:ip]) }

    context 'unique_visit' do
      let(:visit) { { page: '/contact', ip: '1.1.1.1' } }
      it 'adds the visit' do
        add_unique_visit
        expect(subject.visits['/contact'][:unique_ips]).to include '1.1.1.1'
        expect(subject.visits['/contact'][:unique_visit_count]).to be 2
      end
    end

    context 'non-unique visit' do
      let(:visit) { { page: '/contact', ip: '184.123.665.067' } }
      it 'does not add the visit' do
        add_unique_visit
        expect(subject.visits).to eq expected_results
      end
    end
  end

  describe '#analyse_logs' do
    it 'should create correct data output' do
      expect(subject.visits).to eq expected_results
    end
  end

  describe '#print_all_visits' do
    it 'should hand off to presenter' do
      expect(presenter).to receive(:print_all_visits)
      subject.print_all_visits
    end
  end

  describe '#print_unique_visits' do
    it 'should hand off to presenter' do
      expect(presenter).to receive(:print_unique_visits)
      subject.print_unique_visits
    end
  end

  describe '#introduction' do
    it 'should hand off to presenter' do
      expect(presenter).to receive(:print_introduction)
      subject.print_introduction
    end
  end
end
