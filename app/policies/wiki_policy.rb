class WikiPolicy < ApplicationPolicy
	class Scope
  	attr_reader :user, :scope

  	def initialize(user, scope)
  	  @user = user
  	  @scope = scope
  	end

  	def resolve
  	  if user.admin? || user.premium?
  		scope.all
  	  else
  		scope.where(private: false)
  	  end
  	end
	
  end
  

	def show?
	  !@wiki.private || @wiki.private.nil? || current_user.premium? || current_user.admin?
	end

	def delete?
	  user.admin?
	end


end