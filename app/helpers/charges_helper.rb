module ChargesHelper

  def downgrading_wikis
  	current_user.wikis.each do | w |
  	  w.private = false
  	end
  end

end