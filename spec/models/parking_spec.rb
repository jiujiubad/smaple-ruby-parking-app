require 'rails_helper'

RSpec.describe Parking, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe ".validate_end_at_and_amount" do

    #it "is valid with start_at, parking_type, end_at, amount" do
    #  parking = Parking.new( :parking_type => "guest",
    #                         :start_at => Time.now - 6.hours,
    #                         :end_at => Time.now,
    #                         :amount => 999)
    #  expect( parking ).to be_valid
    #  # 這等同於 expect( parking.valid? ).to eq(true)
    #end

    it "is invalid without amount" do
      parking = Parking.new( :parking_type => "guest",
                             :start_at => Time.now - 6.hours,
                             :end_at => Time.now)
      expect( parking ).to_not be_valid
    end

    it "is invalid without amount" do
      parking = Parking.new( :parking_type => "guest",
                             :start_at => Time.now - 6.hours,
                             :amount => 999)
      expect( parking ).to_not be_valid
    end

  end

end
