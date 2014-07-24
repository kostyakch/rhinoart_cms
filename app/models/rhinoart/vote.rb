class Vote < ActiveRecord::Base
	has_one :user, as: :userable, class_name: "Rhinoart::User", :autosave => true, :dependent => :destroy
	accepts_nested_attributes_for :user, allow_destroy: true 

	has_many :vote_questions
end
