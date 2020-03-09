require 'rails_helper'

RSpec.describe Product, type: :model do 
  category = Category.new(name:"test")

  subject { 
    described_class.new({name: "Red Bookshelf",
                        price: 10000,
                        quantity: 10,
                        category: category
    })  
} 
  describe 'Validations' do
    it "should be valid" do
      expect(subject).to be_valid
    end
    it "validates name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
    it "validates price" do
      subject.price_cents = nil
      expect(subject).to_not be_valid
    end
    it "validates quantity" do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end
    it "validates category" do
      subject.category = nil
      expect(subject).to_not be_valid
    end
  end
end
