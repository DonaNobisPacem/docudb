class Document < ActiveRecord::Base
	validates :control, presence: true, uniqueness: true
	validates :office, presence: true
	validates :date, presence: true
	#validates :received_by, presence: true
	validates_presence_of :received_by, if: :is_ingoing?
	validates :subject, presence: true
	#validates :action_subject, presence: true
	#validates :action_done, presence: true
	validates :outgoing, inclusion: [true, false]
	validates :archival, inclusion: [true, false]
	validates :completed, inclusion: [true, false]
	validates :fyi, inclusion: [true, false]
	validates :follow_up, inclusion: [true, false]

	has_many :attachments, dependent: :destroy, inverse_of: :document
	accepts_nested_attributes_for :attachments, allow_destroy: true

	searchkick
	acts_as_xlsx

	def office_name
		Office.find(office).name
	end

	def flow_status
		if outgoing == true
			return "Outgoing"
		elsif outgoing == false
			return "Ingoing"
		else
			return "Status Unavailable"
		end
	end

	def archival_status
		if archival == true
			return "Archived"
		elsif archival == false
			return "Active"
		else
			return "Archival Status Unavailable"
		end
	end

	def transaction_status
		if completed == true
			return "Transaction Completed"
		elsif completed == false
			return "Transaction Active"
		else
			return "Transaction Completion Status Unavailable"
		end
	end

	def information_status
		if fyi == true
			return "Information Only/No Action Required"
		elsif fyi == false
			return "Action Required"
		else
			return "Status Unavailable"
		end
	end

	def follow_status
		if follow_up == true
			return "For Follow Up"
		elsif follow_up == false
			return "Not For Follow Up"
		else
			return "Status Unavailable"
		end
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
