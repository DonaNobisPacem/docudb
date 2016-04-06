class Document < ActiveRecord::Base
	validates :control, presence: true, uniqueness: true
	validates :office, presence: true
	validates :date, presence: true
	#validates :received_by, presence: true
	validates_presence_of :received_by, if: :is_ingoing?
	validates :subject, presence: true
	validates :outgoing, inclusion: [true, false]

	has_many :attachments, dependent: :destroy, inverse_of: :document
	accepts_nested_attributes_for :attachments, allow_destroy: true

	searchkick
	acts_as_xlsx

	def office_name
		Office.find(office).name
	end

	private

		def is_ingoing?
			if outgoing
				return false
			else
				return true
			end
		end
end
