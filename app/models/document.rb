class Document < ActiveRecord::Base
	validates :control, presence: true, uniqueness: true
	validates :office, presence: true
	validates :date, presence: true
	validates :received_by, presence: true
	validates :subject, presence: true
	validates :outgoing, inclusion: [true, false]

	searchkick

	def office_name
		Office.find(office).name
	end
end
