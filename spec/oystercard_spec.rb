require './lib/oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it "has an initial balance of 0" do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe "#top_up" do
    it "can top up the balance" do
      expect {subject.top_up 10 }.to change{ subject.balance }.by 10
    end

    it "has a top_up limit" do
      #Oystercard::TOP_UP_LIMIT = 10
      expect(Oystercard::TOP_UP_LIMIT.class).to be Fixnum
    end

    it "fails if you try to exceed top-up limit" do
      maximum_balance = Oystercard::TOP_UP_LIMIT
      subject.top_up(maximum_balance)
      expect{subject.top_up 1}.to raise_error "Top-up limit of £#{maximum_balance} exceeded."
    end
  end

  describe "#deduct" do
    it "should deduct amount" do
      subject.top_up 40
      expect {subject.deduct 20}.to change{subject.balance}.by (-20)
    end
  end

  describe "#in_journey" do
    it {is_expected.to respond_to(:in_journey?)}
  end

  describe "#touch_in" do
    it "should make in_journey true" do
      subject.top_up(Oystercard::TOP_UP_LIMIT)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it "fails if balance is insufficient" do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      expect{subject.touch_in}.to raise_error "Card empty - #{minimum_balance} required"
    end
  end

  describe "#touch_out" do
    it "should make in_journey false" do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end



end
