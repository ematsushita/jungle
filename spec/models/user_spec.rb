require 'rails_helper'

RSpec.describe User, type: :model do
  subject { 
    described_class.new({first_name: "John",
                        last_name: "Doe",
                        email: "johndoe@email.com",
                        password: "password",
                        password_confirmation: "password"
    })  
}
  describe 'Validations' do
    it "should be valid" do
      expect(subject).to be_valid
    end
    it "validates first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end
    it "validates last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end
    it "validates email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end
    it "validates password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end
    it "validates password matches password confirmation" do
      subject.password_confirmation = "pass"
      subject.validate
      expect(subject.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "validates email is unique" do
      testuser = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "johndoe@email.com",
        password: "password",
        password_confirmation: "password"
        )
      testuser.save
      expect(subject).to_not be_valid
    end
    it "validates password minimum length" do
      subject.password = "pass"
      expect(subject).to_not be_valid
    end
  end
  describe '.authenticate_with_credentials' do
    it "should not return nil for saved user" do
      subject.save
      expect(User.authenticate_with_credentials(subject.email, subject.password)).to_not be_nil
    end
    it "should return nil for unsaved user" do
      expect(User.authenticate_with_credentials(subject.email, subject.password)).to be_nil
    end
    it "should not return nil for saved user with extra spaces and capital letters" do
      subject.save
      expect(User.authenticate_with_credentials("     JOHNdoe@email.com", subject.password)).to_not be_nil
    end
  end
end
