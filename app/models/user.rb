class User < ActiveRecord::Base
  
has_many :wikis, dependent: :destroy

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

  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable



  enum role: [:standard, :premium, :admin]

end
