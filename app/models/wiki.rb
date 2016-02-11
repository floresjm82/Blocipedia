class Wiki < ActiveRecord::Base
  has_many :collaborators
  # belongs_to :user
  has_many :users, through: :collaborators

  delegate :users, to: :collaborators

  def collaborators
  	collaborator.where(wiki_id: id)
  end

  # def users
  # 	# User.where( id: collaborators.pluck(:user_id))
 	# collaborators.users
  # end


end
