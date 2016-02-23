require 'rails_helper'

RSpec.describe "attachments/edit", type: :view do
  before(:each) do
    @attachment = assign(:attachment, Attachment.create!(
      :attachment => "MyString",
      :document => nil
    ))
  end

  it "renders the edit attachment form" do
    render

    assert_select "form[action=?][method=?]", attachment_path(@attachment), "post" do

      assert_select "input#attachment_attachment[name=?]", "attachment[attachment]"

      assert_select "input#attachment_document_id[name=?]", "attachment[document_id]"
    end
  end
end
