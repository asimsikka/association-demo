class Projx < ActiveRecord::Base
	belongs_to :user
  
  has_many :contribution_requests, -> { where(accepted: false) }, class_name: 'Contribution'
  has_many :contributions, -> { where(accepted: true) }
  has_many :contributors, through: :contributions, source: :user

end
