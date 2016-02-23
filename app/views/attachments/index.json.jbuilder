json.array!(@attachments) do |attachment|
  json.extract! attachment, :id, :attachment, :document_id
  json.url attachment_url(attachment, format: :json)
end
