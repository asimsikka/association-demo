class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projxes
  has_many :contribution_requests, -> { where(accepted: false) }, class_name: 'Contribution'
  has_many :contributions, -> { where(accepted: true) }
  has_many :contributed_projxes, through: :contributions, source: :projx
end
