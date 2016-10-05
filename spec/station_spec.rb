require 'station'

describe Station do

  describe '#initialize' do
    let(:subject) {described_class.new(:oxford_circus, 1)}
    it 'sets a station name upon initialization' do
      expect(subject.name).to eq :oxford_circus
    end
    it 'sets a zone upon initialization' do
      expect(subject.zone).to eq 1
    end
  end

end
