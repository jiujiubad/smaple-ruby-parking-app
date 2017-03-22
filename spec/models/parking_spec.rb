require 'rails_helper'

RSpec.describe Parking, type: :model do

  describe ".calculate_amount" do
    before do
      @time = Time.new(2017,3, 27, 8, 0, 0)
    end

    context "short-term" do

      before do
        @user = User.create( :email => "test@example.com", :password => "123455678")
        @parking = Parking.new( :parking_type => "short-term", :user => @user, :start_at => @time )
      end

      it "30 mins should be ¥2" do
        @parking.end_at = @time + 30.minutes
        @parking.save
        expect(@parking.amount).to eq(200)
      end

      it "60 mins should be ¥2" do
        @parking.end_at = @time + 60.minutes
        @parking.save
        expect( @parking.amount ).to eq(200)
      end

      it "61 mins should be ¥2.5" do
        @parking.end_at = @time + 61.minutes
        @parking.save
        expect( @parking.amount ).to eq(250)
      end

      it "90 mins should be ¥2.5" do
        @parking.end_at = @time + 90.minutes
        @parking.save
        expect( @parking.amount ).to eq(250)
      end

      it "120 mins should be ¥3" do
        @parking.end_at = @time + 120.minutes
        @parking.save
        expect( @parking.amount ).to eq(300)
      end

    end

    context "guest" do

      before do
        @parking = Parking.new( :parking_type => "guest", :user => @user, :start_at => @time )
      end

      it "30 mins should be ¥2" do
        @parking.end_at = @time + 30.minutes
        @parking.save
        expect(@parking.amount).to eq(200)
      end

      it "60 mins should be ¥2" do
        @parking.end_at = @time + 60.minutes
        @parking.save
        expect( @parking.amount ).to eq(200)
      end

      it "61 mins should be ¥3" do
        @parking.end_at = @time + 61.minutes
        @parking.save
        expect( @parking.amount ).to eq(300)
      end

      it "90 mins should be ¥3" do
        @parking.end_at = @time + 90.minutes
        @parking.save
        expect( @parking.amount ).to eq(300)
      end

      it "120 mins should be ¥4" do
        @parking.end_at = @time + 120.minutes
        @parking.save
        expect( @parking.amount ).to eq(400)
      end
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
                             :amount => 999)
      expect( parking ).to_not be_valid
    end

  end

end
