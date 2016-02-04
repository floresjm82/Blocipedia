class WikiPolicy
	att_reader :user, :wiki

	def initialize(user, wiki)
		@user = user
		@wiki = wiki
	end

	def show?
      !@wiki.private || @wiki.private.nil? || current_user.premium? || current_user.admin?
    end

	def delete?
	  user.admin?
	end
	
  class Scope
  	def resolve
      if user.admin? || user.premium?
        scope.all
      else
        scope.where(private: false || nil)
    end
  end


end