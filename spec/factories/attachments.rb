FactoryGirl.define do
  factory :attachment do
    attachment Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'files', 'test_attachment.pdf'))
    document
  end
end
