class WikiPolicy
	att_reader :user, :wiki

	def initialize(user, wiki)
		@user = user
		@wiki = wiki
	end

	def delete?
		user.admin?
	end
	
end