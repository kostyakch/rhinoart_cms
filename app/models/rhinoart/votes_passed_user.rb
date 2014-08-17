module Rhinoart
  class VotesPassedUser < ActiveRecord::Base
  	belongs_to :vote
  	belongs_to :user

  	has_many :vote_user_answers
  end
end
