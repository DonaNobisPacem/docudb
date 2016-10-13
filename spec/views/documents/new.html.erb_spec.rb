require 'rails_helper'

RSpec.describe "documents/new", type: :view do
  before(:each) do
    assign(:document, Document.new(
      :control => "MyString",
      :office => 1,
      :received_by => "MyString",
      :subject => "MyString"
    ))
  end

  it "renders new document form" do
    render

    assert_select "form[action=?][method=?]", documents_path, "post" do

      assert_select "input#document_control[name=?]", "document[control]"

      assert_select "input#document_office[name=?]", "document[office]"

      assert_select "input#document_received_by[name=?]", "document[received_by]"

      assert_select "input#document_subject[name=?]", "document[subject]"
    end
  end
end
