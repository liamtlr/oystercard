require 'oystercard'

describe Oystercard do
  it 'initializes a balance' do
    expect(subject.balance).to eq 0
  end

  describe 'card balance' do
    it 'tops up a card' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end
  end
end
