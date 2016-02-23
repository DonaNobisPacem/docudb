require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it "has a valid factory" do
  	expect( FactoryGirl.build(:attachment) ).to be_valid
  end

  describe "ActiveModel Validations" do
  	it { should validate_presence_of(:attachment) }
  end

  describe "ActiveRecord Validations" do
  	it { should belong_to(:document) }
  	it { should validate_presence_of(:document) }
  end
end
