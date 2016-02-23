require 'rails_helper'

RSpec.describe "attachments/index", type: :view do
  before(:each) do
    assign(:attachments, [
      Attachment.create!(
        :attachment => "Attachment",
        :document => nil
      ),
      Attachment.create!(
        :attachment => "Attachment",
        :document => nil
      )
    ])
  end

  it "renders a list of attachments" do
    render
    assert_select "tr>td", :text => "Attachment".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
