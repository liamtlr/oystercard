require './lib/oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let (:station) {double(:station)}

  it "has an initial balance of 0" do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to :list_journeys }


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

  context "when topped up" do
    before(:each) do
      subject.top_up(Oystercard::TOP_UP_LIMIT)
    end

    describe "#touch_in" do
      it "should make in_journey true" do
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end

      it "should remember the entry station" do
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end

    end

    describe "#touch_out" do
      it "should make in_journey false" do
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject).not_to be_in_journey
      end

      it "should deduct the right amount upon touching out" do
        subject.touch_in(station)
        expect{subject.touch_out(station)}.to change{subject.balance}.by (-Oystercard::FARE)
      end
    end

    describe "#list_journeys" do
      it "defaults to empty array" do
        expect(subject.list_journeys).to eq []
      end

      it "remembers a journey" do
        subject.touch_in("Chorleywood")
        subject.touch_out("Knightsbridge")
        expect(subject.list_journeys).to eq [{entry_station: :chorleywood, exit_station: :knightsbridge}]
      end

    end


  end
  context "when not topped up" do
    describe "#touch_in" do
      it "fails if balance is insufficient" do
        minimum_balance = Oystercard::MINIMUM_BALANCE
        expect{subject.touch_in(station)}.to raise_error "Card empty - #{minimum_balance} required"
      end
    end
  end



end
