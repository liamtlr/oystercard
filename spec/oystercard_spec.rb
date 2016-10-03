require 'oystercard'

describe Oystercard do
  it 'initializes a balance' do
    expect(subject.balance).to eq 0
  end
end
