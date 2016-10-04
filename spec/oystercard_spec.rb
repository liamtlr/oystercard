require 'spec_helper'

describe Oystercard do

  let(:station) { double :station }
  let(:exit_station) { double :station }

  min_fare = Oystercard::MINIMUM_FARE
  max_balance = Oystercard::MAXIMUM_BALANCE

  it { is_expected.to respond_to(:top_up).with(1).argument }
  it { is_expected.to respond_to(:touch_out).with(1).argument }
  it { is_expected.to respond_to(:touch_in).with(1).argument }

  describe '#initialize' do
    it 'has an initial balance of zero' do
      expect(subject.balance).to eq(0)
    end
    it 'is not initially in a journey' do
      expect(subject).not_to be_in_journey
    end
    it 'initially contains no journey history' do
      expect(subject.journey_history).to be_empty
    end
  end

context 'card being used to touch in and out' do
  before do
      subject.top_up(min_fare)
      subject.touch_in(station)
    end
    it 'can touch in' do
      expect(subject).to be_in_journey
    end
    it 'can touch out' do
    subject.touch_out(station)
    expect(subject).not_to be_in_journey
    end
    it 'remembers the entry station' do
      expect(subject.entry_station).to eq station
    end
    it 'forgets entry station on touch out' do
      subject.touch_out(station)
      expect(subject.entry_station).to eq nil
    end
    it 'charges minimum fare on touch out' do
      expect {subject.touch_out(station)}.to change{subject.balance}.by(-min_fare)
    end
  end

  context 'card can be topped up and wont exceed the maximum balance' do
    it 'can top up the balance' do
      expect{subject.top_up(min_fare)}.to change{subject.balance}.by min_fare
    end

    it 'raises an exception if maximum balance is exceeded' do
      subject.top_up(max_balance)
      expect{subject.top_up min_fare}.to raise_error "Maximum balance of #{max_balance} exceeded"
    end
  end

  context 'amounts can be deducted from card and wont allow touch in if insufficient funds' do
    it 'deducts an amount from the balance' do
      subject.top_up(max_balance)
      expect{subject.touch_out(station)}.to change{subject.balance}.by -min_fare
    end
    it "wont touch in if below minimum balance" do
      expect{subject.touch_in(station)}.to raise_error 'Insufficient funds for jouney'
    end
  end

end
