require 'rails_helper'

RSpec.describe Office, type: :model do
  it "has a valid factory" do
  	expect( FactoryGirl.build(:office) ).to be_valid
  end

  describe "ActiveModel Validations" do
  	it { should validate_presence_of(:name) }
  	it { should validate_uniqueness_of(:name) }
  end
end
