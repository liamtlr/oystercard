require 'spec_helper'

describe Oystercard do

  let(:station) { double :station }

  it 'has an initial balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }
  it { is_expected.to respond_to(:touch_out) }
  it { is_expected.to respond_to(:touch_in).with(1).argument }

  it 'is not initially in a journey' do
    expect(subject).not_to be_in_journey
  end

  it 'remembers the entry station' do
    subject.top_up(Oystercard::MINIMUM_FARE)
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end

  it 'forgets entry station on touch out' do
    subject.top_up(Oystercard::MINIMUM_FARE)
    subject.touch_in(station)
    subject.touch_out
    expect(subject.entry_station).to eq nil
  end

context 'card being used to touch in and out' do
  before do
    subject.top_up(Oystercard::MINIMUM_FARE)
    subject.touch_in(station)
  end
  it 'can touch in' do
    expect(subject).to be_in_journey
  end
  it 'can touch out' do
    subject.touch_out
    expect(subject).not_to be_in_journey
  end
end

  it 'charges minimum fare on touch out' do
    expect {subject.touch_out}.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
  end

  context 'card can be topped up and wont exceed the maximum balance' do
    it 'can top up the balance' do
      expect{subject.top_up(Oystercard::MINIMUM_FARE)}.to change{subject.balance}.by Oystercard::MINIMUM_FARE
    end

    it 'raises an exception if maximum balance is exceeded' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect{subject.top_up Oystercard::MINIMUM_FARE}.to raise_error "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
    end
  end

  context 'Amounts can be deducted from card and wont allow touch in if insufficient funds' do
    it 'deducts an amount from the balance' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect{subject.touch_out}.to change{subject.balance}.by -Oystercard::MINIMUM_FARE
    end
    it "wont touch in if below minimum balance" do
      expect{subject.touch_in(station)}.to raise_error 'Insufficient funds for jouney'
    end
  end

end
