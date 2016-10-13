json.array!(@documents) do |document|
  json.extract! document, :id, :control, :office, :date, :received_by, :subject
  json.url document_url(document, format: :json)
end
