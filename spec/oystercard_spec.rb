require 'oystercard'

describe Oystercard do
  it 'initializes a balance' do
    expect(subject.balance).to eq 0
  end
  it { is_expected.to respond_to(:top_up).with(1).argument }
  it { is_expected.to respond_to(:deduct).with(1).argument }

  describe 'card balance' do
    it 'tops up a card' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end
    it 'cannot have a balance exceeding the maximum' do
      maximum_balance = Oystercard::MAX_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up(1) }.to raise_error "Maxmimum card balance is £#{maximum_balance}"
    end

    it 'deducts the journey fare' do
      subject.top_up(30)
      subject.deduct(12)
      expect(subject.balance).to eq 18
    end
  end

end
