require "spec_helper"

RSpec.describe Nupack do
  it "has a version number" do
    expect(Nupack::VERSION).not_to be nil
  end

    describe "Given Valid Inputs.." do
      context "Given Base Price $1,299.99,3 people, food" do
        it "Outputs $1,591.58" do
          value = CostEstimation.new("$1,299.99", "3 people", "food").price
          expect(value).to eq("$1,591.58")
        end
      end

      context "Given Base Price $5,432.00,1 person,drugs" do
        it "Outputs $6,199.81" do
          value = CostEstimation.new("$5,432.00", "1 person", "drugs").price
          expect(value).to eq("$6,199.81")
        end
      end
      context "Given Base Price $1256.95,4 people, electronics" do
        it "Outputs $1,409.54" do
          value = CostEstimation.new("$$1256.95", "4 people", "electronics").price
          expect(value).to eq("$1,409.54")
        end
      end

      context "Given Base Price $12,456.95,4 people,books" do
        it "Outputs $13,707.63" do
          value = CostEstimation.new("$12,456.95", "4 people", "books").price
          expect(value).to eq("$13,707.63")
        end
      end

      context "Given Base Price $0,4 people,books" do
        it "Outputs $0.00" do
          value = CostEstimation.new("0", "4 people", "books").price
          expect(value).to eq("$0.00")
        end

      end

      context "given $10340.00, 1 person,others" do
        it "Outputs $10,987.28" do
          value = CostEstimation.new("$10340.00", "1 person", "others").price
          expect(value).to eq("$10,987.28")
        end
      end
      context "given $1030.00, 1 person, Burger" do
        it "Outputs $1,094.48" do
          value = CostEstimation.new("$1030.00", "1 person", "Burger").price
          expect(value).to eq("$1,094.48")
        end
      end
      context "given $1030.00,1 person, Tyre" do
        it "Outputs $1,094.48" do
          value = CostEstimation.new("$1030.00", "1 person", "Tyre").price
          expect(value).to eq("$1,094.48")
        end
      end

      context "given $93,115.64, 1 person, n/a" do
        it "Outputs $98,944.68" do
          value = CostEstimation.new("$93,115.64", "1 person", "n/a").price
          expect(value).to eq("$98,944.68")
        end
      end

      context "Given Input ($876.00, 9 person, Shampoo)" do
        it "Outputs $101,948.74" do
          value = CostEstimation.new("$876.00", "9 person", "Shampoo").price
          expect(value).to eq("$1,019.14")
        end
      end
    end

    describe "Provided Invalid Input.." do
      it "Invalid value input" do
        expect { CostEstimation.new("Twinkle Twinkle", "Little Star 3 person", "food").price }.to raise_error("Input Invalid. Please check the format!")
      end

      context "given $434,sfsf 3 person,food" do
        it "Invalid value input" do
          expect { CostEstimation.new("$434", "sfsf 3 person", "food").price }.to raise_error("Invalid person input!")
        end
      end
    end

    describe "Calculate markup for People With different materials" do
      it "Outputs $1,185.91" do
        value = CostEstimation.new("$989", "1 person", "food").price
        expect(value).to eq("$1,185.91")
      end
      it "Outputs $81,760.91" do
        value = CostEstimation.new("$67,888", "6 person", "drugs").price
        expect(value).to eq("$81,760.91")
      end
      it "Outputs $98,944.68" do
        value = CostEstimation.new("$93,115", "1 person", "electronics").price
        expect(value).to eq("$100,899.41")
      end

      it "Outputs $13,116.73" do
        value = CostEstimation.new("$12,344", "1 person", "Car").price
        expect(value).to eq("$13,116.73")
      end
      it "Outputs $12,961.20" do
        value = CostEstimation.new("$12,344", "0 person", "Car").price
        expect(value).to eq("$12,961.20")
      end

    end
  end


