class CollaboratorsController < ApplicationController
      def create
            @wiki = Wiki.find(params[:wiki_id])
            c = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])
            if c.save
                  flash[:notice] = 'Collaborator added'
            else
                  flash[:alert] = 'Fail'
            end
            redirect_to [@wiki.user, @wiki]
      end

      def destroy
            @wiki = Wiki.find(params[:wiki_id])
            user = User.find(params[:user_id])
            c = Collaborator.find_by(user_id: user.id, wiki_id: @wiki.id)
            if c.destroy
                  flash[:notice] = 'Collaborator removed'
            else
                  flash[:alert] = 'Fail'
            end
                  redirect_to [@wiki.user, @wiki]
            end
      end
end
