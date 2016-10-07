require 'oystercard'

describe Oystercard do
  subject { described_class.new }
  let(:entry_station) {double(:station, :name => "waterloo", :zone => 1)}
  let(:exit_station) {double(:station, :name => "borough", :zone => 1)}
  let(:other_station) {double(:station, :name => "london bridge", :zone => 2)}
  let(:the_sticks) {double(:station, :name => "chesham", :zone => 12)}
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
      subject.touch_in(entry_station)
      expect{subject.touch_in(entry_station)}.to change{subject.balance}.by(-1*(described_class::PENALTY_FARE))
    end
  end

  describe '#touch_out' do

    before(:each) do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
    end

    it 'deducts the correct amount from card' do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-described_class::MINIMUM_FARE)
    end

    it "charges penalty if you touch out twice" do
      subject.touch_out(entry_station)
      expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-1*described_class::PENALTY_FARE)
    end

    it "charges 2 for a journey zone 2 to 1" do
      expect{subject.touch_out(other_station)}.to change{subject.balance}.by(-2)
    end

    it "charges 1 for a journey completed in the same zone" do
      expect{subject.touch_out(entry_station)}.to change{subject.balance}.by(-1)
    end

    it "charges loads when you go really far" do
      expect{subject.touch_out(the_sticks)}.to change{subject.balance}.by(-12)
    end
  end

  describe "going from the stick to the inner city" do
    it "charges the same aount for a journey above done in reverse" do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(the_sticks)
      expect{subject.touch_out(entry_station)}.to change{subject.balance}.by(-12)


    end

  end

  describe '#initialize' do

    it 'balance is zero' do
      expect(subject.balance).to eq(0)
    end
  end

end
