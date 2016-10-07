require 'oystercard'

describe Oystercard do
  subject { described_class.new }
  let(:entry_station) {double(:station)}
  let(:exit_station) {double(:station)}
  let(:journey) {double(:journey)} #{ {entry_station: entry_station, exit_station: exit_station} }

  context 'With max balance on card' do
    before do
      subject.top_up(described_class::MAXIMUM_BALANCE)
    end

    it 'can not be topped up beyond limit' do
      message = "Beyond limit of #{described_class::MAXIMUM_BALANCE}"
      expect{subject.top_up(1)}.to raise_error message
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect{ subject.top_up 1}.to change{ subject.balance }.by 1
    end
  end

  describe '#touch_in' do

    it 'raises error when insufficient balance' do
      expect{subject.touch_in(entry_station)}.to raise_error "Insufficient balance"
    end

    it 'if user touches in twice, they are charged a penalty' do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in("borough")
      expect{subject.touch_in("waterloo")}.to change{subject.balance}.by(-1*(described_class::PENALTY_FARE))
    end
  end

  describe '#touch_out' do

    before(:each) do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
    end

    it 'deducts the correct amount from card' do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by (-described_class::MINIMUM_FARE)
    end

    it "charges penalty if you touch out twice" do
      subject.touch_out(double(:station))
      expect{subject.touch_out(double(:station))}.to change{subject.balance}.by(-1*described_class::PENALTY_FARE)
    end
  end

  describe '#initialize' do

    it 'balance is zero' do
      expect(subject.balance).to eq(0)
    end
  end

end
