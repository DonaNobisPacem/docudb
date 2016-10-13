require 'rails_helper'

RSpec.describe "documents/show", type: :view do
  before(:each) do
    @document = assign(:document, Document.create!(
      :control => "Control",
      :office => 1,
      :received_by => "Received By",
      :subject => "Subject"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Control/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Received By/)
    expect(rendered).to match(/Subject/)
  end
end
