class WikisController < ApplicationController
      before_action :set_record, except: [:index, :new, :create]
      before_action :authenticate_user!

       def index
         # if current_user.admin?
         #   @wikis = Wiki.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
         # elsif current_user.premium?
         #   #Show all public wikis and owned private wikis
         #   #@wikis = "Not sure how to define collection"
         # else
         #   #current_user.standard?
         #   #Show only public wikis
         #   @wikis = Wiki.where(private: false).order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
         # end

         #@wikis = current_user.wikis.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
         #@wikis = Wiki.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
         #@wikiPrivateCount = Wiki.where(private: true).count.to_s
         @wikis = Wiki.visible_to(current_user).ordered.paginate(:page => params[:page], :per_page => 5)
         @personalWikiCount = current_user.wikis.count.to_s
         @PersonalWikiPrivateCount = current_user.wikis.where(private: true).count.to_s
       end

       def show
         # Render the show view
       end

       def create
         @wiki = current_user.wikis.build(wiki_params)

         if @wiki.save
           flash[:notice] = "saved"
           redirect_to wikis_path
         else
           flash[:error] = @wiki.errors.full_messages.to_sentence
           render :new
         end
       end

       def edit
         # Render the edit view
         # @ wiki is set in the private set_record method and executed by the before_action:
         #@wiki = Wiki.find(params[:id])
         authorize @wiki
       end

       def update
         # @item = Item.find(params[:id]) - not necessary because of before_action to set item
          @wiki.assign_attributes(wiki_params)
          authorize @wiki
          if @wiki.save
            flash[:notice] = "Wiki was updated."
           redirect_to wikis_path
          else
            flash[:error] = @wiki.errors.full_messages.to_sentence
            render :edit
          end
       end

       def new
         @wiki = Wiki.new
       end

       def destroy
          @wiki = Wiki.find(params[:id])

          if @wiki.destroy
            flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
            redirect_to action: :index
          else
            flash[:error] = "There was an error deleting the wiki."
            render :show
          end
       end

       private

       def set_record
         @wiki = Wiki.find(params[:id])
         # begin
         #   @wiki = current_user.wikis.find(params[:id])
         # rescue
         #   @wiki = nil
         # end
       end

       def wiki_params
         params.require(:wiki).permit(:title, :body, :private)
       end
     end
