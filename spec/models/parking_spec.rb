require 'rails_helper'

RSpec.describe Parking, type: :model do

  describe ".calculate_amount" do
    it "30 mins should be ¥2" do
      t = Time.now
      parking = Parking.new( :parking_type => "guest", :start_at => t, :end_at => t + 30.minutes )
      parking.calculate_amount
      expect(parking.amount).to eq(2)
    end

    it "60 mins should be ¥2" do
      t = Time.now
      parking = Parking.new( :parking_type => "guest", :start_at => t, :end_at => t + 60.minutes )
      parking.calculate_amount
      expect( parking.amount ).to eq(2)
    end

    it "61 mins should be ¥3" do
      t = Time.now
      parking = Parking.new( :parking_type => "guest", :start_at => t, :end_at => t + 61.minutes )
      parking.calculate_amount
      expect( parking.amount ).to eq(3)
    end

    it "90 mins should be ¥3" do
      t = Time.now
      parking = Parking.new( :parking_type => "guest", :start_at => t, :end_at => t + 90.minutes )
      parking.calculate_amount
      expect( parking.amount ).to eq(3)
    end

    it "120 mins should be ¥4" do
      t = Time.now
      parking = Parking.new( :parking_type => "guest", :start_at => t, :end_at => t + 120.minutes )
      parking.calculate_amount
      expect( parking.amount ).to eq(4)
    end

  end


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
