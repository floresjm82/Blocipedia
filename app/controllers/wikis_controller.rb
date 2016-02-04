class WikisController < ApplicationController

	#before_actions.....

	def index

	  @wikis = WikiPolicy::Scope.new(current_user, Wiki).resolve

	end

	def show

	  @wiki = Wiki.find(params[:id])
	  authorize @wiki 

	end


	def new

	  @wiki = Wiki.new

	end


	def create

	  # @wiki = Wiki.new
	  # @wiki.title = params[:wiki][:title]
	  # @wiki.body = params[:wiki][:body]
	  # @wiki.public = params[:wiki][:public]
	  # @wiki.user = current_user

	  @wiki = current_user.wikis.new(wiki_params)

	  if @wiki.save
	  	flash[:notice] = "Wiki saved!"
	  else
	  	flash[:error] = "Error... the Wiki was NOT saved!"
	  end

	  redirect_to current_user

	end


	def edit

	  @wiki = Wiki.find(params[:id])

	end


	def update

	  @wiki = Wiki.find(params[:id])
	  @wiki.assign_attributes(wiki_params)

	  if @wiki.save
	  	flash[:notice] = "Wiki updated!"
	  	redirect_to @wiki
	  else
	  	flash[:error] = "Error... the Wiki was NOT updated"
	  	render :edit
	  end

	end


	def destroy

	  @wiki = Wiki.find(params[:id])
	  authorize @wiki

	  if @wiki.destroy
	  	flash[:notice] = "\'#{wiki.title}\' was deleted successfully."
	    redirect_to action: :index
	  else
	  	flash[:error] = "There was an error deleting the wiki."
	  	render :show
	  end

	end

    private

    def wiki_params
    	params.require(:wiki).permit(:title, :body, :private)
    end



end


