class Question < ActiveRecord::Base
  belongs_to :survey, presence: true
end
