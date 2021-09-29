require 'oystercard'

RSpec.describe Oystercard do
  let(:subject) { described_class.new(10) }
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  describe "#initialize" do
    it 'checks that the Oystercard class exists' do
      expect(subject.respond_to?(:oystercard))
    end
  end

  describe "#balance" do
    it 'checks that a new card has a balance' do
      expect(subject.balance).to eq 10
    end
  end

  describe "#journey_history" do
    it 'checks that a new journey history array is made' do
      expect(subject.journey_history).to eq([])
    end
  end
  

  describe "#top_up" do
    it 'should add money to the balance, and take in the amount as an argument' do
      expect(subject.top_up(20)).to eq 30
    end
  
    it 'should add money to the balance, and take in the amount as an argument' do
      expect(subject.top_up(30)).to eq 40
    end  

    it 'should raise error when maximum balance of 90 reached' do
      expect(subject.top_up(1000)).to eq "Maximum limit of 90 reached"
    end

    it 'should not allow money to be added if this would be more than the maximum balance' do
      subject.top_up(1000)
      expect(subject.balance).to eq 10
    end
  end

  describe "#in_journey?" do
    it 'checks the journey status of a new oystercard' do
      expect(subject.in_journey?).to eq false
    end
  end

  describe "#touch_in" do
    it 'it changes the oystercard status to on a journey (@on_a_journey = true)' do
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end

    it 'sets the entry station on touch in' do
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

    it 'throws an error if a card with unsufficient balance is touched in' do
      subject = Oystercard.new(0)
      expect{subject.touch_in(entry_station)}.to raise_error("Insufficient card balance")
    end
  end

  describe "#touch_out" do
    it 'it changes the oystercard status to not on a journey (@on_a_journey = false)' do
      subject.touch_in(entry_station)
      expect{ subject.touch_out(exit_station) }.to change { subject.in_journey? }.to false
    end

    it 'it charges the oystercard the minimum fare when we touch out' do
      expect{subject.touch_out(exit_station)}.to change{subject.balance}.by (-1)
    end

    it 'resets entry station to nil on touch out' do
      subject.touch_in(entry_station)
      expect{ subject.touch_out(exit_station) }.to change { subject.entry_station }.to nil
    end

    it 'adds a complete journey to the journey_history array' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expected = {:entry => entry_station, :exit => exit_station}
      expect(subject.journey_history).to include expected
    end
  end

end
