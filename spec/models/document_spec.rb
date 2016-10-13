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
    #it { should validate_presence_of(:action_subject) }
    #it { should validate_presence_of(:action_done) }

  	it { should validate_uniqueness_of(:control) }

  	context "Boolean validation" do
  		it { should allow_value(true).for(:outgoing) }
		  it { should allow_value(false).for(:outgoing) }
		  it { should_not allow_value(nil).for(:outgoing) }

      it { should allow_value(true).for(:archival) }
      it { should allow_value(false).for(:archival) }
      it { should_not allow_value(nil).for(:archival) }

      it { should allow_value(true).for(:completed) }
      it { should allow_value(false).for(:completed) }
      it { should_not allow_value(nil).for(:completed) }

      it { should allow_value(true).for(:fyi) }
      it { should allow_value(false).for(:fyi) }
      it { should_not allow_value(nil).for(:fyi) }

      it { should allow_value(true).for(:follow_up) }
      it { should allow_value(false).for(:follow_up) }
      it { should_not allow_value(nil).for(:follow_up) }
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
      it "returns \"Archived\" when archival is true" do 
        document = FactoryGirl.create(:document, archival: true)
        expect(document.archival_status).to eq("Archived")
      end

      it "returns \"Active\" when archival is false" do 
        document = FactoryGirl.create(:document, archival: false)
        expect(document.archival_status).to eq("Active")
      end
    end

    context "returns the correct transactional status description" do
      it "returns \"Transaction Completed\" when completed is true" do 
        document = FactoryGirl.create(:document, completed: true)
        expect(document.transaction_status).to eq("Transaction Completed")
      end

      it "returns \"Transaction Active\" when completed is false" do 
        document = FactoryGirl.create(:document, completed: false)
        expect(document.transaction_status).to eq("Transaction Active")
      end
    end

    context "returns the correct information status description" do
      it "returns \"For Information Only/No Action Required\" when fyi is true" do 
        document = FactoryGirl.create(:document, fyi: true)
        expect(document.information_status).to eq("Information Only/No Action Required")
      end

      it "returns \"Action Required\" when fyi is false" do 
        document = FactoryGirl.create(:document, fyi: false)
        expect(document.information_status).to eq("Action Required")
      end
    end

    context "returns the correct follow up status description" do
      it "returns \"For Follow Up\" when follow up is true" do 
        document = FactoryGirl.create(:document, follow_up: true)
        expect(document.follow_status).to eq("For Follow Up")
      end

      it "returns \"Not For Follow Up\" when follow up is false" do 
        document = FactoryGirl.create(:document, follow_up: false)
        expect(document.follow_status).to eq("Not For Follow Up")
      end
    end
  end
end
