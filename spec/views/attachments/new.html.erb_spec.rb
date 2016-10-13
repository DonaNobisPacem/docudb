require 'rails_helper'

RSpec.describe "attachments/new", type: :view do
  before(:each) do
    assign(:attachment, Attachment.new(
      :attachment => "MyString",
      :document => nil
    ))
  end

  it "renders new attachment form" do
    render

    assert_select "form[action=?][method=?]", attachments_path, "post" do

      assert_select "input#attachment_attachment[name=?]", "attachment[attachment]"

      assert_select "input#attachment_document_id[name=?]", "attachment[document_id]"
    end
  end
end
