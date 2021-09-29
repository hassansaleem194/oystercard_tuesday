require 'station'

describe Station do
  let(:subject) {described_class.new("name", 1)}

  describe '#name' do
    it 'returns the name' do
      expect(subject.name).to eq "name"
    end
  end

  describe '#zone' do
    it 'returns the zone' do
      expect(subject.zone).to eq 1
    end
  end
end
