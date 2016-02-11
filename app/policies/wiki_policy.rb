class WikiPolicy < ApplicationPolicy
  class Scope
     attr_reader :user, :scope
 
     def initialize(user, scope)
       @user = user
       @scope = scope
     end
 
     def resolve
       wikis = []
       if user.role == 'admin'
         wikis = scope.all # if the user is an admin, show them all the wikis
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki.public? || wiki.owner == user || wiki.collaborators.include?(user)
             wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
           end
         end
       else # this is the lowly standard user
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if wiki.public? || wiki.collaborators.include?(user)
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
           end
         end
       end
       wikis # return the wikis array we've built up
     end
   end

   #  def publicly_viewable
   #    scope.where(private: false || nil)
   #  end

  	# def resolve
  	#   if user.admin?
  	# 	  scope.all
  	#   elsif user.premium?
  	# 	  premium_scope = user.wikis
   #      premium_scope << publicly_viewable
   #    else user.standard?
   #      publicly_viewable
  	#   end
  	# end
  

	def show?
	  !@wiki.private || @wiki.private.nil? || user.premium? || user.admin?
	end

	def delete?
	  user.admin?
	end




end