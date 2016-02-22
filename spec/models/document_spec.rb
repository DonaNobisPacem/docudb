require 'rails_helper'

RSpec.describe Document, type: :model do
  it "has a valid factory" do
  	expect( FactoryGirl.build(:document) ).to be_valid
  end

  describe "ActiveModel Validations" do
  	it { should validate_presence_of(:control) }
  	it { should validate_presence_of(:office) }
  	it { should validate_presence_of(:date) }
  	it { should validate_presence_of(:received_by) }
  	it { should validate_presence_of(:subject) }

  	it { should validate_uniqueness_of(:control) }

  	context "Outgoing boolean validation" do
  		it { should allow_value(true).for(:outgoing) }
		it { should allow_value(false).for(:outgoing) }
		it { should_not allow_value(nil).for(:outgoing) }
  	end
  end
end
