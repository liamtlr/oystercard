require 'oystercard'

describe Oystercard do
  it 'initializes a balance' do
    expect(subject.balance).to eq 0
  end
  it { is_expected.to respond_to(:top_up).with(1).argument }
  it { is_expected.to respond_to(:deduct).with(1).argument }
  it { is_expected.to respond_to(:touch_in) }

  describe 'card balance' do
    it 'tops up a card' do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by 10
    end
    it 'cannot have a balance exceeding the maximum' do
      maximum_balance = Oystercard::MAX_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up(1) }.to raise_error "Maxmimum card balance is £#{maximum_balance}"
    end
    it 'deducts the journey fare' do
      subject.top_up(30)
      expect{ subject.deduct(3) }.to change{ subject.balance }.by -3
    end
  end

  describe 'card status' do
    it 'declines cards that do not have the minimum balance' do
      expect{ subject.touch_in }.to raise_error "Insufficient funds: please top up"
    end
    it 'touches in' do
      subject.top_up(2)
      subject.touch_in
      expect(subject).to be_in_journey
    end
    it 'shows if in journey' do
      expect(subject).not_to be_in_journey
    end
    it 'touches out' do
      subject.top_up(2)
      subject.touch_in
      subject.touch_out
      expect(subject).to_not be_in_journey
    end
  end

end
