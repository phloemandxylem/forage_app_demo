class WikisController < ApplicationController
  def index
        @wiki = Wiki.all
  end

  def show
        @wiki = Wiki.find(params[:id])
  end

  def new
        @wiki = Wiki.new
  end

  def create
     @wiki = Wiki.new
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]

     if @wiki.save
           flash[:notice] = "wiki was saved."
           redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :new
     end
 end

  def edit
         @wiki = Wiki.find(params[:id])

  end

  def update
        @wiki = Wiki.find(params[:id])
        @wiki.title = params[:post][:title]
        @wiki.body = params[:post][:body]

        if @wiki.save
             flash[:notice] = "Post was updated."
            redirect_to @wiki
        else
             flash.now[:alert] = "There was an error saving the post. Please try again."
            render :edit
      end
    end
end
