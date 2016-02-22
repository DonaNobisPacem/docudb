require 'rails_helper'

RSpec.describe "documents/index", type: :view do
  before(:each) do
    assign(:documents, [
      Document.create!(
        :control => "Control",
        :office => 1,
        :received_by => "Received By",
        :subject => "Subject"
      ),
      Document.create!(
        :control => "Control",
        :office => 1,
        :received_by => "Received By",
        :subject => "Subject"
      )
    ])
  end

  it "renders a list of documents" do
    render
    assert_select "tr>td", :text => "Control".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Received By".to_s, :count => 2
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
  end
end
