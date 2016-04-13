require 'rails_helper'

RSpec.describe Document, type: :model do
  it "has a valid factory" do
  	expect( FactoryGirl.build(:document) ).to be_valid
  end

  describe "ActiveModel Validations" do
  	it { should validate_presence_of(:control) }
  	it { should validate_presence_of(:office) }
  	it { should validate_presence_of(:date) }
  	#it { should validate_presence_of(:received_by) }
  	it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:action_subject) }
    it { should validate_presence_of(:action_done) }

  	it { should validate_uniqueness_of(:control) }

  	context "Outgoing boolean validation" do
  		it { should allow_value(true).for(:outgoing) }
		  it { should allow_value(false).for(:outgoing) }
		  it { should_not allow_value(nil).for(:outgoing) }


      it { should allow_value(true).for(:archival) }
      it { should allow_value(false).for(:archival) }
      it { should_not allow_value(nil).for(:archival) }
  	end

    context "Ingoing Document" do
      before(:each) { allow(subject).to receive(:is_ingoing?).and_return(true) }
      it { should validate_presence_of(:received_by) }
    end

    context "Outgoing Document" do
      before(:each) { allow(subject).to receive(:is_ingoing?).and_return(false) }
      it { should_not validate_presence_of(:received_by) }
    end
  end

  describe "ActiveRecord Validations" do
    it { should have_many(:attachments) }
    it { should accept_nested_attributes_for(:attachments).allow_destroy(true) }
  end

  describe "Custom functions validations" do
    context "returns the correct flow status description" do
      it "returns \"Outgoing\" when outgoing is true" do 
        document = FactoryGirl.create(:document, outgoing: true)
        expect(document.flow_status).to eq("Outgoing")
      end

      it "returns \"Ingoing\" when outgoing is false" do 
        document = FactoryGirl.create(:document, outgoing: false)
        expect(document.flow_status).to eq("Ingoing")
      end
    end

    context "returns the correct archival status description" do
      it "returns \"For Archival\" when archival is true" do 
        document = FactoryGirl.create(:document, archival: true)
        expect(document.archival_status).to eq("For Archival")
      end

      it "returns \"Active\" when archival is false" do 
        document = FactoryGirl.create(:document, archival: false)
        expect(document.archival_status).to eq("Active")
      end
    end
  end
end
