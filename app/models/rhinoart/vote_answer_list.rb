module Rhinoart
	class VoteAnswerList < ActiveRecord::Base
		belongs_to :vote_question
		has_one :vote_user_answer

		
		FIELD_TYPES = { text: 'Text', textarea: 'Textarea', radio_group: 'RadioGroup', check_box: 'CheckBox', phone: 'Phone', email: 'Email' }
		validates :field_type, inclusion: { in: FIELD_TYPES.keys.map(&:to_s) }

		def self.select_list
			FIELD_TYPES.map { |ft| [ft[1], ft[0]] }
		end
	end
end