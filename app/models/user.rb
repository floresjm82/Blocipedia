class User < ActiveRecord::Base
  
has_many :wikis, dependent: :nullify

before_save do 
	self.email = email.downcase
end

after_initialize :defaults

def defaults
	self.role ||= :standard	#self.role = :standard if self.role.nil?
end

def downgrading_wikis!
  wikis.update_all(private: false)
end

def collaborators
  Collaborator.where(user_id: id)
end

def collaborated_wikis
	collaborators.map(&:wiki)
end

def all_wikis
	wikis + collaborated_wikis
end

# def wikis
#   # Wiki.where( id: collaborators.pluck(:wiki_id))
#   collaborators.wikis
# end

  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable



  enum role: [:standard, :premium, :admin]

end
