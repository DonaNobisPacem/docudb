class Document < ActiveRecord::Base
	validates :control, presence: true, uniqueness: true
	validates :office, presence: true
	validates :date, presence: true
	#validates :received_by, presence: true
	validates :subject, presence: true
	validates :outgoing, inclusion: [true, false]

	has_many :attachments, dependent: :destroy, inverse_of: :document
	accepts_nested_attributes_for :attachments, allow_destroy: true

	searchkick
	acts_as_xlsx

	def office_name
		Office.find(office).name
	end
end
