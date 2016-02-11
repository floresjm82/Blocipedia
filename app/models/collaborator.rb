class Collaborator < ActiveRecord::Base

	belongs_to :user 
	belongs_to :wiki 
	# Should dependent: :destroy add on be applied here?

  def self.users
  	User.where(id: pluck(:user_id))
  end

  def self.wikis
  	Wiki.where(id: pluck(:wiki_id))
  end

  def wiki
  	Wiki.find(wiki_id)
  end

  def user
  	User.find(user_id)
  end

end
