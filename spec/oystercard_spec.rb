
require './lib/oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  let (:station1) { double(:station, name: "Old Street", zone: 1) }
  let (:station2) { double(:station, name: "Kentish Town", zone: 2) }

  let (:station3) { double(:station, name: "Chorleywood", zone: 1) }
  let (:station4) { double(:station, name: "Marylebone", zone: 2) }

  let (:journey1) {double(:journey)}
  allow(journey1).to receive(:stations).and_return({station1: station2})

  let (:journey2) {double(:journey)}
  allow(journey2).to receive(:stations).and_return({station3: station4})


    it "has an initial balance of 0" do
      expect(subject.balance).to eq 0
    end


    describe "#top_up" do
      it "can top up the balance" do
        expect {subject.top_up 10 }.to change{ subject.balance }.by 10
      end

      it "has a top_up limit" do
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

      it 'creates an instance of Journey' do
        journey = subject.touch_in(station1)
        expect(subject.current_journey).to eq journey
      end

      it 'ends journey if already touched in' do


      end

    end

    describe "#touch_out" do
      it "should make in_journey false" do
        subject.touch_in(station1)
        subject.touch_out(station2)
        expect(subject).not_to be_in_journey
      end

      it "should deduct the right amount upon touching out" do
        subject.touch_in(station1)
        expect{subject.touch_out(station2)}.to change{subject.balance}.by (-Oystercard::FARE)
      end
    end

    describe "#list_journeys" do

      it "defaults to empty array" do
        expect(subject.list_journeys).to eq []
      end

      it "remembers a journey" do
        subject.touch_in(station1)
        subject.touch_out(station2)
        subject.touch_in(station1)
        subject.touch_out(station2)
        expect(subject.list_journeys).to eq [journey1, journey2]
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
