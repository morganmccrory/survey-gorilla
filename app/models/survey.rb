class Survey < ActiveRecord::Base
  belongs_to :user, foreign_key: :creator_id
  has_many :questions
  has_many :completions
end
