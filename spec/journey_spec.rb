require 'journey'

describe Journey do

  let(:subject) { described_class.new(station) }
  let(:station) { double(:station, name: 'Old Street', zone: 1) }
  let(:exit_station) { double :station, name: 'Kentish Town', zone: 2}

    describe '#initialize' do
      it 'receives an entry station' do
      expect(subject.entry_station).to eq station
    end
    end

    describe '#end_journey' do
      it 'receives an exit station' do
        subject.end_journey(exit_station)
        expect(subject.exit_station).to eq exit_station
      end
    end

    describe '#complete?' do

        it 'knows journey is complete' do
          subject.end_journey(exit_station)
          expect(subject.complete?).to eq true
        end
        it 'knows journey is incomplete' do
          expect(subject.complete?).to eq false
      end

    end

    describe '#fare' do

      it 'defaults to a penalty fare' do
        penalty_fare = Journey::PENALTY_FARE
        expect(subject.fare).to eq penalty_fare
      end

      it 'changes to minimum fare if journey completed' do
        subject.end_journey(exit_station)
        expect(subject.fare).to eq Journey::MIN_FARE
      end

    end


end
